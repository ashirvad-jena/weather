//
//  WeatherErrors.swift
//  Weather
//
//  Created by Ashirvad Jena on 16/05/21.
//

import Foundation

enum WeatherError: Error {
    case fetchFailure
    case invalidCityName
    case cityAlreadyFetched
    case unknown
}

extension WeatherError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .fetchFailure:
            return "Oops!!. Couldn't fetch results. Please try after sometime."
        case .invalidCityName:
            return "Please enter valid city name"
        case .cityAlreadyFetched:
            return "City is already available in weathers list!!"
        case .unknown:
            return "Something went wrong. Please try again."
        }
    }
}
