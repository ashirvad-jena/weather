//
//  WeatherListPresenter.swift
//  Weather
//
//  Created by Ashirvad Jena on 16/05/21.
//

import Foundation

protocol WeatherListPresentationLogic {
    func presentFetchedWeathers(response: WeatherList.ShowWeathers.Response)
}

class WeatherListPresenter: WeatherListPresentationLogic {

    weak var viewObject: WeatherListDisplayLogic?
    
    private var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter
    }()
    
    func presentFetchedWeathers(response: WeatherList.ShowWeathers.Response) {
        var displayWeathers: [WeatherList.ShowWeathers.ViewModel.DisplayWeather] = []
        displayWeathers = response.weatherModels.map({ weatherModel in
            return WeatherList.ShowWeathers.ViewModel.DisplayWeather(
                date: timeFormatter.string(from: weatherModel.date),
                city: weatherModel.cityName,
                temperature: String(format: "%.1f°C", weatherModel.temperature))
        })
        let viewModel = WeatherList.ShowWeathers.ViewModel(displayWeathers: displayWeathers)
        DispatchQueue.main.async {
            self.viewObject?.displayWeathers(viewModel: viewModel)
        }
    }
}
