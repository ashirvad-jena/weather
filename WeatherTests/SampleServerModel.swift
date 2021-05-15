//
//  SampleServerModel.swift
//  WeatherTests
//
//  Created by Ashirvad Jena on 15/05/21.
//

@testable import Weather
import XCTest

struct SampleServerModel {
    static func getModel(for searchName: String) -> ServerWeatherModel {
        let mockModel = ServerWeatherModel(
            coord: ServerWeatherModel.Coord(
                lon: 37.39,
                lat: -122.08),
            weather: [
                ServerWeatherModel.Weather(
                    id: 800,
                    main: "Clear",
                    weatherDescription: "clear sky",
                    icon: "01d")
            ],
            base: "stations",
            main: ServerWeatherModel.Main(
                temp: 22.5,
                feelsLike: 16,
                tempMin: 12.2,
                tempMax: 24.3,
                pressure: 1023,
                humidity: 100),
            visibility: 16093,
            wind: ServerWeatherModel.Wind(
                speed: 1.5,
                deg: 350),
            clouds: ServerWeatherModel.Clouds(all: 1),
            dt: 1560350645,
            sys: ServerWeatherModel.Sys(
                type: 1,
                id: 5122,
                country: "US",
                sunrise: 1560343627,
                sunset: 1560396563),
            timezone: -25200,
            id: 420006353,
            name: searchName,
            cod: 200)
        return mockModel
    }
}
