//
//  WeatherDetailUseCases.swift
//  Weather
//
//  Created by Ashirvad Jena on 16/05/21.
//

import UIKit

/// Defines one use case for `Detail Weather` scene i.e, Show weather details of a particular city
enum WeatherDetailUseCases {
    
    enum DetailWeather {
        struct Request {}
        
        struct Response {
            let weatherModel: WeatherModel?
        }
        
        struct ViewModel {
            struct Header {
                let cityName: String?
                let weatherType: String?
                let weatherTypeImageUrl: URL?
                let temperature: String?
                var highTemperature: String? = nil
                var lowTemperature: String? = nil
                let description: String?
            }
            struct Param {
                var imageIcon: UIImage?
                var title: String?
                var detail: String?
            }
            
            struct DisplayWeather {
                let header: Header
                let params: [Param]
            }
            var displayWeather: DisplayWeather?
//            var header: Header
//            var params: [Param] = []
        }
    }
}
