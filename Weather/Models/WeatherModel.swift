//
//  WeatherModel.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import Foundation

struct WeatherModel {
    let cityId: Int
    let cityName: String
    let weatherType: String?
    let weatherIconId: String?
    let date: Date
    let temperature: Double
    let highTemperature: Double?
    let lowTemperature: Double?
    let description: String?
    let feelsLikeTemperature: Double?
    let pressure: Int?
    let humidity: Int?
    let cloudiness: Double?
    let sunrise: Date?
    let sunset: Date?
}
