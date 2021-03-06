//
//  SearchCityModel.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import Foundation

enum SearchCityUseCases {
    
    enum FetchWeather {
        struct Request {
            let searchCityName: String
        }
        
        struct Response {
            let weatherModel: WeatherModel?
            let error: Error?
        }
    }
}
