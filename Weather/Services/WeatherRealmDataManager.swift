//
//  WeatherRealmDataManager.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import Foundation

class WeatherRealmDataManager: DatabaseManager, WeatherDatabaseProtocol {
    
    func saveWeatherToLocalStorage(_ model: WeatherModel) {
        let realmObject = WeatherRealmobjcect()
        realmObject.cityId = model.cityId
        realmObject.cityName = model.cityName
        realmObject.weatherType = model.weatherType ?? ""
        realmObject.weatherIconId = model.weatherIconId ?? ""
        realmObject.date = model.date
        realmObject.temperature = model.temperature
        realmObject.highTemperature = model.highTemperature ?? 0.0
        realmObject.lowTemperature = model.lowTemperature ?? 0.0
        realmObject.typeDescription = model.description ?? ""
        realmObject.feelsLikeTemperature = model.feelsLikeTemperature ?? 0.0
        realmObject.pressure = model.pressure ?? 0
        realmObject.humidity = model.humidity ?? 0
        realmObject.cloudiness = model.cloudiness ?? 0
        realmObject.sunrise = model.sunrise ?? Date()
        realmObject.sunset = model.sunset ?? Date()
        realmObject.createdDate = Date()
        write {
            realm.add(realmObject)
        }
    }
    
    func readAllWeathersFromStorage() -> [WeatherModel] {
        let realmObjects = realm.objects(WeatherRealmobjcect.self)
            .sorted(byKeyPath: "createdDate")
        var weatherModels: [WeatherModel] = []
        weatherModels = realmObjects.map({ realmObj in
            return WeatherModel(cityId: realmObj.cityId,
                                cityName: realmObj.cityName,
                                weatherType: realmObj.weatherType,
                                weatherIconId: realmObj.weatherIconId,
                                date: realmObj.date,
                                temperature: realmObj.temperature,
                                highTemperature: realmObj.highTemperature,
                                lowTemperature: realmObj.lowTemperature,
                                description: realmObj.typeDescription,
                                feelsLikeTemperature: realmObj.feelsLikeTemperature,
                                pressure: realmObj.pressure,
                                humidity: realmObj.humidity,
                                cloudiness: realmObj.cloudiness,
                                sunrise: realmObj.sunrise,
                                sunset: realmObj.sunset)
        })
        return weatherModels
    }
    
    func isCityAvailable(_ cityId: Int) -> Bool {
        if let _ = realm.objects(WeatherRealmobjcect.self).filter("cityId == \(cityId)").first {
            return true
        } else {
            return false
        }
    }
}
