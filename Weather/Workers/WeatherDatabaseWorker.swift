//
//  WeatherDatabaseWorker.swift
//  Weather
//
//  Created by Ashirvad Jena on 16/05/21.
//

import Foundation

protocol WeatherDatabaseProtocol {
    func saveWeatherToLocalStorage(_ weatherModel: WeatherModel)
}

class WeatherDatabaseWorker {
    
    var cityWeather: WeatherDatabaseProtocol?
    
    init(cityWeather: WeatherDatabaseProtocol) {
        self.cityWeather = cityWeather
    }
    
    func save(weatherModel: WeatherModel) {
        cityWeather?.saveWeatherToLocalStorage(weatherModel)
    }
}