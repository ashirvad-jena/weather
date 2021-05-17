//
//  WeatherDetailInteractor.swift
//  Weather
//
//  Created by Ashirvad Jena on 16/05/21.
//

import Foundation

/// Holds data for the `detail weather` scene
protocol WeatherDetailDataSource {
    var weatherModel: WeatherModel? { get set }
}

/// Defines methods to be called to fetch weather details
protocol WeatherDetailBusinessLogic {
    func getDetailWeather()
}

/// Responible for getting request from `ViewController`,  and handing processed data to presenter
class WeatherDetailInteractor: WeatherDetailDataSource, WeatherDetailBusinessLogic {
    
    var weatherModel: WeatherModel?
    var presenter: WeatherDetailPresentationLogic?
    
    func getDetailWeather() {
        let response  = WeatherDetailUseCases.DetailWeather.Response(weatherModel: weatherModel)
        presenter?.showWeatherDetail(response: response)
    }
}
