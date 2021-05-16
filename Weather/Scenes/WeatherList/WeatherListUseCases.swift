//
//  WeatherListUseCases.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import Foundation

enum WeatherListUseCases {
    
    // Use Cases
    enum ShowWeathers {
        
        struct Response {
            var weatherModels: [WeatherModel] = []
        }
        
        struct ViewModel {
            struct DisplayWeather {
                let date: String
                let city: String
                let temperature: String
            }
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
}
