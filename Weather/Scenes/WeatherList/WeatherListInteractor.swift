//
//  WeatherListInteractor.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import Foundation

/// Business Logic for `weatherList scene`, which `Interactor` should adhere, to prepare the data before handing over to `Presenter`
protocol WeatherListBusinessLogic {
    /// Fetch list of city's weathers' from local storage
    func fetchWeathers()
    /// update each of the city in local storage with latest data and update corresponding ui
    func updateWeathers()
    /// Deletes the selected weather by the user
    /// - Parameter index: index of the model to be deleted
    func deleteWeather(at index: Int)
}

/// Data source to be used for the List of weather
protocol WeatherListDataSource {
    var weathers: [WeatherModel] { get }
}

/// This class is responsible for all the business logic
class WeatherListInteractor: WeatherListBusinessLogic, WeatherListDataSource {

    var presenter: WeatherListPresentationLogic?
    let databaseWorker = WeatherDatabaseWorker(cityWeather: WeatherRealmDataManager())
    let networkWorker = WeatherNetworkWorker(cityWeather: WeatherAPI())
    var weathers: [WeatherModel] = []
    
    func fetchWeathers() {
        weathers = databaseWorker.fetchAllWeathers()
        let response = WeatherListUseCases.ShowWeathers.Response(weatherModels: weathers)
        presenter?.presentFetchedWeathers(response: response)
    }
    
    func updateWeathers() {
        let cityNames = databaseWorker.fetchAllCityNames()
        cityNames.forEach { cityName in
            networkWorker.cityWeather?.fetchWeatherFromApi(for: cityName, completionHandler: { serverModel, error in
                guard let serverModel = serverModel else { return }
                self.updateWeatherModel(from: serverModel)
            })
        }
    }
    
    func deleteWeather(at index: Int) {
        guard index < weathers.count else {
            presenter?.presentDeleteWeather(response: WeatherListUseCases.DeleteWeather.Response(error: WeatherError.unableToDeleteCity, weatherModel: nil))
            return
        }
        let weatherModel = weathers[index]
        let error = databaseWorker.delete(weatherModel: weatherModel)
        if error == nil {
            weathers.remove(at: index)
        }
        presenter?.presentDeleteWeather(response: WeatherListUseCases.DeleteWeather.Response(error: error, weatherModel: weatherModel))
        fetchWeathers()
    }
    
    
    /// Updates local storage, UI with latest data
    /// - Parameter serverModel: model received from server
    private func updateWeatherModel(from serverModel: ServerWeatherModel) {
        let weatherModel = Utility.mapServerModelToWeatherModel(serverModel)
        databaseWorker.update(weatherModel: weatherModel)
        if let updatedWeatherModel = databaseWorker.readWeatherModel(for: weatherModel.cityId),
           let index = weathers.firstIndex(where: { $0.cityId == updatedWeatherModel.cityId }) {
            weathers[index] = updatedWeatherModel
            let response = WeatherListUseCases.UpdateWeather.Response(updatedWeatherModel: weatherModel, updatedIndex: index)
            presenter?.presentReloadWeather(response: response)
        }
    }
}
