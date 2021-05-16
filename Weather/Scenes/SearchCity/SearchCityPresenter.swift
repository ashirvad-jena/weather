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
        if let error = response.error {
            DispatchQueue.main.async {
                self.viewObject?.showError(message: error.localizedDescription)
            }
        } else if let cityName = response.weatherModel?.cityName {
            DispatchQueue.main.async {
                self.viewObject?.displayResult(cityName: cityName)
            }
        } else {
            preconditionFailure()
        }
    }
}
