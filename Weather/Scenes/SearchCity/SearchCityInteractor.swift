//
//  SearchCityInteractor.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import Foundation

protocol SearchCityBusinessLogic {
    func fetchWeatherDetails(for request: SearchCityUseCases.FetchWeather.Request)
    func mapServerModelToWeatherModel(_ serverModel: ServerWeatherModel)
    func saveWeatherModel()
}

class SearchCityInteractor: SearchCityBusinessLogic {
    
    var presenter: SearchCityPresentationLogic?
    let weatherWorker = WeatherWorker(cityWeather: WeatherAPI())
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
                    self.mapServerModelToWeatherModel(serverModel)
                    self.presenter?.presentResult(from: SearchCityUseCases.FetchWeather.Response(weatherModel: self.weatherModel, error: nil))
                }
            }
        })
    }
    
    func mapServerModelToWeatherModel(_ serverModel: ServerWeatherModel) {
        let model = WeatherModel(
            cityId: serverModel.id,
            cityName: serverModel.name,
            weatherType: serverModel.weather?.first?.main,
            weatherIconId: serverModel.weather?.first?.icon,
            date: Date(timeIntervalSince1970: TimeInterval(serverModel.dt ?? 0)),
            temperature: serverModel.main.temp,
            highTemperature: serverModel.main.tempMax,
            lowTemperature: serverModel.main.tempMin,
            description: serverModel.weather?.first?.weatherDescription ?? "",
            feelsLikeTemperature: serverModel.main.feelsLike,
            pressure: serverModel.main.pressure,
            humidity: serverModel.main.humidity,
            cloudiness: serverModel.clouds?.all,
            sunrise: Date(timeIntervalSince1970: TimeInterval(serverModel.sys?.sunrise ?? 0)),
            sunset: Date(timeIntervalSince1970: TimeInterval(serverModel.sys?.sunset ?? 0)))
        
        weatherModel = model
    }
    
    func saveWeatherModel() {
        guard let weatherModel = weatherModel else { return }
        databaseWorker.save(weatherModel: weatherModel)
    }
}
