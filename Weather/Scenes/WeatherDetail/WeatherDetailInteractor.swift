//
//  WeatherDetailInteractor.swift
//  Weather
//
//  Created by Ashirvad Jena on 16/05/21.
//

import Foundation

protocol WeatherDetailDataSource {
    var weatherModel: WeatherModel? { get set }
}

protocol WeatherDetailBusinessLogic {
    func getDetailWeather()
}

class WeatherDetailInteractor: WeatherDetailDataSource, WeatherDetailBusinessLogic {
    
    var weatherModel: WeatherModel?
    var presenter: WeatherDetailPresentationLogic?
    
    func getDetailWeather() {
        let response  = WeatherDetailUseCases.DetailWeather.Response(weatherModel: weatherModel)
        presenter?.showWeatherDetail(response: response)
    }
}
