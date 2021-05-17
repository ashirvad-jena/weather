//
//  Utility.swift
//  Weather
//
//  Created by Ashirvad Jena on 16/05/21.
//

import Foundation

func delay(seconds: Double, completion: @escaping ()-> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

struct Utility {
    
    static func mapServerModelToWeatherModel(_ serverModel: ServerWeatherModel) -> WeatherModel {
        let model = WeatherModel(
            cityId: serverModel.id,
            cityName: serverModel.name,
            weatherType: serverModel.weather?.first?.main,
            weatherIconId: serverModel.weather?.first?.icon,
            date: Date(timeIntervalSince1970: TimeInterval(serverModel.dt ?? 0)),
            temperature: serverModel.main.temp,
            highTemperature: serverModel.main.tempMax,
            lowTemperature: serverModel.main.tempMin,
            description: serverModel.weather?.first?.weatherDescription,
            feelsLikeTemperature: serverModel.main.feelsLike,
            pressure: serverModel.main.pressure,
            humidity: serverModel.main.humidity,
            cloudiness: serverModel.clouds?.all,
            sunrise: Date(timeIntervalSince1970: TimeInterval(serverModel.sys?.sunrise ?? 0)),
            sunset: Date(timeIntervalSince1970: TimeInterval(serverModel.sys?.sunset ?? 0)))
        
        return model
    }
}
