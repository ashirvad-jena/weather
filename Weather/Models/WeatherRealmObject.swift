//
//  WeatherRealmobjcect.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import RealmSwift
import Foundation

class WeatherRealmobjcect: Object {
    @objc dynamic var cityId = 0
    @objc dynamic var cityName = ""
    @objc dynamic var weatherType: String? = nil
    @objc dynamic var weatherIconId: String? = nil
    @objc dynamic var date = Date()
    @objc dynamic var temperature = 0.0
    @objc dynamic var highTemperature = 0.0
    @objc dynamic var lowTemperature = 0.0
    @objc dynamic var typeDescription: String?
    @objc dynamic var feelsLikeTemperature = 0.0
    @objc dynamic var pressure = 0
    @objc dynamic var humidity = 0
    @objc dynamic var cloudiness = 0.0
    @objc dynamic var sunrise: Date?
    @objc dynamic var sunset: Date?
    @objc dynamic var createdDate = Date()
}
