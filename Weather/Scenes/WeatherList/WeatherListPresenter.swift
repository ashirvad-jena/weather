//
//  WeatherListPresenter.swift
//  Weather
//
//  Created by Ashirvad Jena on 16/05/21.
//

import Foundation

protocol WeatherListPresentationLogic {
    func presentFetchedWeathers(response: WeatherListUseCases.ShowWeathers.Response)
    func presentDeleteWeather(response: WeatherListUseCases.DeleteWeather.Response)
}

class WeatherListPresenter: WeatherListPresentationLogic {

    weak var viewObject: WeatherListDisplayLogic?
    
    private var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter
    }()
    
    func presentFetchedWeathers(response: WeatherListUseCases.ShowWeathers.Response) {
        var displayWeathers: [WeatherListUseCases.ShowWeathers.ViewModel.DisplayWeather] = []
        displayWeathers = response.weatherModels.map({ weatherModel in
            return WeatherListUseCases.ShowWeathers.ViewModel.DisplayWeather(
                date: timeFormatter.string(from: weatherModel.date),
                city: weatherModel.cityName,
                temperature: String(format: "%.1f°C", weatherModel.temperature))
        })
        let viewModel = WeatherListUseCases.ShowWeathers.ViewModel(displayWeathers: displayWeathers)
        DispatchQueue.main.async {
            self.viewObject?.displayWeathers(viewModel: viewModel)
        }
    }
    
    func presentDeleteWeather(response: WeatherListUseCases.DeleteWeather.Response) {
        if let error = response.error {
            viewObject?.displayDeletionStatus(status: error.localizedDescription)
        } else {
            viewObject?.displayDeletionStatus(status: "Deleted " + (response.weatherModel?.cityName ?? ""))
        }
    }
}
