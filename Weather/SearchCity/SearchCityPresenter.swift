//
//  SearchCityPresenter.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import Foundation

protocol SearchCityPresentationLogic {
    func presentResult(from: SearchCity.FetchWeather.Response)
}

class SearchCityPresenter: SearchCityPresentationLogic {
    
    weak var viewObject: SearchCityDisplayLogic?
    
    func presentResult(from response: SearchCity.FetchWeather.Response) {
        var result = ""
        if let weatherModel = response.weatherModel {
            result = weatherModel.cityName
        }
        result = "Oops!! Couldn't find a city. Please try again."
        viewObject?.displayResult(string: result)
    }
}
