//
//  WeatherDatabaseWorker.swift
//  Weather
//
//  Created by Ashirvad Jena on 16/05/21.
//

import Foundation

protocol WeatherDatabaseProtocol {
    func saveWeatherToLocalStorage(_ weatherModel: WeatherModel)
    func readAllWeathersFromStorage() -> [WeatherModel]
    func isCityAvailable(_ cityId: Int) -> Bool
    func delete(cityId: Int) -> Error?
    func fetchAllCityNames() -> [String]
    func update(weatherModel: WeatherModel)
    func fetchWeather(for cityId: Int) -> WeatherModel?
}

class WeatherDatabaseWorker {
    
    var cityWeather: WeatherDatabaseProtocol?
    
    init(cityWeather: WeatherDatabaseProtocol) {
        self.cityWeather = cityWeather
    }
    
    func save(weatherModel: WeatherModel) {
        cityWeather?.saveWeatherToLocalStorage(weatherModel)
    }
    
    func fetchAllWeathers() -> [WeatherModel] {
        return cityWeather?.readAllWeathersFromStorage() ?? []
    }
    
    func isCityAvailable(_cityId: Int) -> Bool {
        return cityWeather?.isCityAvailable(_cityId) ?? false
    }
    
    func delete(weatherModel: WeatherModel) -> Error? {
        return cityWeather?.delete(cityId: weatherModel.cityId)
    }
    
    func fetchAllCityNames() -> [String] {
        return cityWeather?.fetchAllCityNames() ?? []
    }
    
    func update(weatherModel: WeatherModel) {
        cityWeather?.update(weatherModel: weatherModel)
    }
    
    func readWeatherModel(for cityId: Int) -> WeatherModel? {
        return cityWeather?.fetchWeather(for: cityId)
    }
}
