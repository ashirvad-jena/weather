//
//  SearchCityInteractor.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import Foundation

protocol SearchCityBusinessLogic {
    func fetchWeatherDetails(for request: SearchCityUseCases.FetchWeather.Request)
    func saveWeatherModel()
}

class SearchCityInteractor: SearchCityBusinessLogic {
    
    var presenter: SearchCityPresentationLogic?
    let weatherWorker = WeatherNetworkWorker(cityWeather: WeatherAPI())
    let databaseWorker = WeatherDatabaseWorker(cityWeather: WeatherRealmDataManager())
    var weatherModel: WeatherModel?
    
    func fetchWeatherDetails(for request: SearchCityUseCases.FetchWeather.Request) {
        weatherWorker.cityWeather?.fetchWeatherFromApi(for: request.searchCityName, completionHandler: { serverModel, error in
            if let error = error {
                self.presenter?.presentResult(from: SearchCityUseCases.FetchWeather.Response(weatherModel: nil, error: error))
                
            } else if let serverModel = serverModel {
                
                if self.databaseWorker.isCityAvailable(_cityId: serverModel.id) {
                    self.presenter?.presentResult(from: SearchCityUseCases.FetchWeather.Response(weatherModel: nil, error: WeatherError.cityAlreadyFetched))
                    
                } else {
                    self.weatherModel = Utility.mapServerModelToWeatherModel(serverModel)
                    self.presenter?.presentResult(from: SearchCityUseCases.FetchWeather.Response(weatherModel: self.weatherModel, error: nil))
                }
            }
        })
    }
    
    func saveWeatherModel() {
        guard let weatherModel = weatherModel else { return }
        databaseWorker.save(weatherModel: weatherModel)
    }
}
