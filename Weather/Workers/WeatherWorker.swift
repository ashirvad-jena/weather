//
//  WeatherNetworkWorker.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import Foundation

protocol FetchCityWeatherProtocol {
    func fetchWeatherFromApi(for searchName: String, completionHandler: @escaping (ServerWeatherModel?, Error?) -> Void)
}

class WeatherWorker {
    
    var cityWeather: FetchCityWeatherProtocol?
    
    init(cityWeather: FetchCityWeatherProtocol) {
        self.cityWeather = cityWeather
    }
    
    func fetchWeatherDetails(for cityName: String, completionHandler: @escaping (ServerWeatherModel?, Error?) -> Void) {
        cityWeather?.fetchWeatherFromApi(for: cityName, completionHandler: { serverWeatherModel, error in
            completionHandler(serverWeatherModel, error)
        })
    }
}
