//
//  WeatherListUseCases.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import Foundation

enum WeatherListUseCases {
    
    struct DisplayWeather {
        let date: String
        let city: String
        let temperature: String
    }
    
    enum ShowWeathers {
        struct Response {
            var weatherModels: [WeatherModel] = []
        }
        
        struct ViewModel {
            var displayWeathers: [DisplayWeather] = []
        }
    }
    
    enum DeleteWeather {
        struct Request {
            var weatherModel: WeatherModel
        }
        
        struct Response {
            var error: Error?
            var weatherModel: WeatherModel?
        }
    }
    
    enum UpdateWeather {
        struct Response {
            let updatedWeatherModel: WeatherModel
            let updatedIndex: Int
        }
        
        struct ViewModel {
            let indexPath: IndexPath
            let displayWeathers: [DisplayWeather]
        }
    }
}
