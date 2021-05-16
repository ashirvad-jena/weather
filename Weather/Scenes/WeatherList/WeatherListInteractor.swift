//
//  WeatherListInteractor.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import Foundation

protocol WeatherListBusinessLogic {
    func fetchWeathers()
    func deleteWeather(at index: Int)
}

protocol WeatherListDataSource {
    var weathers: [WeatherModel] { get }
}

class WeatherListInteractor: WeatherListBusinessLogic, WeatherListDataSource {

    var presenter: WeatherListPresentationLogic?
    let databaseWorker = WeatherDatabaseWorker(cityWeather: WeatherRealmDataManager())
    var weathers: [WeatherModel] = []
    
    func fetchWeathers() {
        weathers = databaseWorker.fetchAllWeathers()
        let response = WeatherListUseCases.ShowWeathers.Response(weatherModels: weathers)
        presenter?.presentFetchedWeathers(response: response)
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
}
