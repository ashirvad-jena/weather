//
//  SearchCityInteractor.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import Foundation

protocol SearchCityBusinessLogic {
    func fetchWeatherDetails(for request: SearchCity.FetchWeather.Request)
    func mapServerModelToWeatherModel(_ serverModel: ServerWeatherModel)
    func saveWeatherModel()
}

class SearchCityInteractor: SearchCityBusinessLogic {
    
    var presenter: SearchCityPresentationLogic?
    let weatherWorker = WeatherWorker(cityWeather: WeatherAPI())
    let databaseWorker = WeatherDatabaseWorker(cityWeather: WeatherRealmDataManager())
    var weatherModel: WeatherModel?
    
    func fetchWeatherDetails(for request: SearchCity.FetchWeather.Request) {
        weatherWorker.cityWeather?.fetchWeatherFromApi(for: request.searchCityName, completionHandler: { serverModel, error in
            if let error = error {
                self.presenter?.presentResult(from: SearchCity.FetchWeather.Response(weatherModel: nil, error: error))
                
            } else if let serverModel = serverModel {
                self.mapServerModelToWeatherModel(serverModel)
                self.presenter?.presentResult(from: SearchCity.FetchWeather.Response(weatherModel: self.weatherModel, error: nil))
            }
        })
    }
    
    func mapServerModelToWeatherModel(_ serverModel: ServerWeatherModel) {
        let model = WeatherModel(
            cityName: serverModel.name,
            weatherType: serverModel.weather?.first?.main,
            date: Date(timeIntervalSince1970: TimeInterval(serverModel.dt ?? 0)),
            temperature: serverModel.main.temp ?? 0.0,
            highTemperature: serverModel.main.tempMax,
            lowTemperature: serverModel.main.tempMin,
            description: serverModel.weather?.description ?? "",
            feelsLikeTemperature: serverModel.main.feelsLike,
            pressure: serverModel.main.pressure,
            humidity: serverModel.main.humidity,
            cloudiness: serverModel.clouds?.all ?? 0.0,
            sunrise: Date(timeIntervalSince1970: TimeInterval(serverModel.sys?.sunrise ?? 0)),
            sunset: Date(timeIntervalSince1970: TimeInterval(serverModel.sys?.sunset ?? 0)))
        
        weatherModel = model
    }
    
    func saveWeatherModel() {
        guard let weatherModel = weatherModel else { return }
        databaseWorker.save(weatherModel: weatherModel)
    }
}
