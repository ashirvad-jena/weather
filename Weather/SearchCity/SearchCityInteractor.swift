//
//  SearchCityInteractor.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import Foundation

protocol SearchCityBusinessLogic {
    func fetchWeatherDetails(for request: WeatherList.FetchWeather.Request)
    func mapServerModelToWeatherModel(_ serverModel: ServerWeatherModel)
}

class SearchCityInteractor: SearchCityBusinessLogic {
    
    let weatherWorker = WeatherWorker(cityWeather: WeatherAPI())
    var weatherModel: WeatherModel?
    
    func fetchWeatherDetails(for request: WeatherList.FetchWeather.Request) {
        weatherWorker.cityWeather?.fetchWeatherFromApi(for: request.searchCityName, completionHandler: { serverModel in
            guard let serverModel = serverModel else { return }
            self.mapServerModelToWeatherModel(serverModel)
        })
    }
    
    func mapServerModelToWeatherModel(_ serverModel: ServerWeatherModel) {
        let model = WeatherModel(
            cityName: serverModel.name,
            weatherType: serverModel.weather.first?.main,
            date: Date(timeIntervalSince1970: TimeInterval(serverModel.dt)),
            temperature: serverModel.main.temp,
            highTemperature: serverModel.main.tempMax,
            lowTemperature: serverModel.main.tempMin,
            description: serverModel.weather.description,
            feelsLikeTemperature: serverModel.main.feelsLike,
            pressure: serverModel.main.pressure,
            humidity: serverModel.main.humidity,
            cloudiness: serverModel.clouds.all,
            sunrise: Date(timeIntervalSince1970: TimeInterval(serverModel.sys.sunrise)),
            sunset: Date(timeIntervalSince1970: TimeInterval(serverModel.sys.sunset)))
        
        weatherModel = model
    }
}
