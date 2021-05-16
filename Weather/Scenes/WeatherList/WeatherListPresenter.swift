//
//  WeatherListPresenter.swift
//  Weather
//
//  Created by Ashirvad Jena on 16/05/21.
//

import Foundation

/// This protocol defines the methods to map  data into presentable format.
protocol WeatherListPresentationLogic {
    /// Maps `WeatherListUseCases.ShowWeathers.Response` into  presentable format after fetching from local storage
    func presentFetchedWeathers(response: WeatherListUseCases.ShowWeathers.Response)
    /// Maps `WeatherListUseCases.DeleteWeather.Response` into presentable format after deletion
    func presentDeleteWeather(response: WeatherListUseCases.DeleteWeather.Response)
    /// Maps `WeatherListUseCases.UpdateWeather.Response` into presentable format after updation
    func presentReloadWeather(response: WeatherListUseCases.UpdateWeather.Response)
}

class WeatherListPresenter: WeatherListPresentationLogic {

    weak var viewObject: WeatherListDisplayLogic?
    private var viewModel: WeatherListUseCases.ShowWeathers.ViewModel?
    
    private var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, hh:mm a"
        return formatter
    }()
    
    func presentFetchedWeathers(response: WeatherListUseCases.ShowWeathers.Response) {
        var displayWeathers: [WeatherListUseCases.DisplayWeather] = []
        displayWeathers = response.weatherModels.map({ weatherModel in
            return WeatherListUseCases.DisplayWeather(
                date: timeFormatter.string(from: weatherModel.date),
                city: weatherModel.cityName,
                temperature: String(format: "%.1f°C", weatherModel.temperature))
        })
        viewModel = WeatherListUseCases.ShowWeathers.ViewModel(displayWeathers: displayWeathers)
        DispatchQueue.main.async {
            self.viewObject?.displayWeathers(viewModel: self.viewModel!)
        }
    }
    
    func presentDeleteWeather(response: WeatherListUseCases.DeleteWeather.Response) {
        if let error = response.error {
            viewObject?.displayDeletionStatus(status: error.localizedDescription)
        } else {
            viewObject?.displayDeletionStatus(status: "Deleted " + (response.weatherModel?.cityName ?? ""))
        }
    }
    
    func presentReloadWeather(response: WeatherListUseCases.UpdateWeather.Response) {
        guard let viewModel = viewModel else { return }
        var existingDisplayWeathers = viewModel.displayWeathers
        let indexPath = IndexPath(row: response.updatedIndex, section: 0)
        let weatherModel = response.updatedWeatherModel
        let displayWeather = WeatherListUseCases.DisplayWeather(
            date: timeFormatter.string(from: weatherModel.date),
            city: weatherModel.cityName,
            temperature: String(format: "%.1f°C", weatherModel.temperature))
        existingDisplayWeathers[response.updatedIndex] = displayWeather
        let updatedViewModel = WeatherListUseCases.UpdateWeather.ViewModel(indexPath: indexPath, displayWeathers: existingDisplayWeathers)
        DispatchQueue.main.async {
            self.viewObject?.displayReload(viewModel: updatedViewModel)
        }
    }
}
