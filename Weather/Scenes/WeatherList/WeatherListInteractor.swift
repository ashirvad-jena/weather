//
//  WeatherListInteractor.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import Foundation

protocol WeatherListBusinessLogic {
    func fetchWeathers()
}

protocol WeatherListDataSource {
    var weathers: [WeatherModel] { get }
}

class WeatherListInteractor: WeatherListBusinessLogic, WeatherListDataSource {

    var presenter: WeatherListPresentationLogic?
    let databaseWorker = WeatherDatabaseWorker(cityWeather: WeatherRealmDataManager())
    var weathers: [WeatherModel] = []
    
    func fetchWeathers() {
        weathers = databaseWorker.fetchAllWeathers()
        let response = WeatherList.ShowWeathers.Response(weatherModels: weathers)
        presenter?.presentFetchedWeathers(response: response)
    }
}
