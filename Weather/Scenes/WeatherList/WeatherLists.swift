//
//  WeatherLists.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import Foundation

enum WeatherList {
    
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
}
