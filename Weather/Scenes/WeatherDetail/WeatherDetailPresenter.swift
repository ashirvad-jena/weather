//
//  WeatherDetailPresenter.swift
//  Weather
//
//  Created by Ashirvad Jena on 16/05/21.
//

import UIKit

protocol WeatherDetailPresentationLogic {
    func showWeatherDetail(response: WeatherDetail.DetailWeather.Response)
}

class WeatherDetailPresenter: WeatherDetailPresentationLogic {
    
    weak var viewController: WeatherDetailViewController?
    
    static let iconUrl = "https://openweathermap.org/img/wn/"
    
    private var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
       return formatter
    }()
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"
       return formatter
    }()
    
    func showWeatherDetail(response: WeatherDetail.DetailWeather.Response) {
        guard let weatherModel = response.weatherModel else { return }
        var desc = weatherModel.description
        if Calendar.current.isDateInToday(weatherModel.date) {
            desc = "Today: " + (desc ?? "")
        } else {
            desc = dateFormatter.string(from: weatherModel.date) + (desc ?? "")
        }
        
        var header = WeatherDetail.DetailWeather.ViewModel.Header(
            cityName: weatherModel.cityName,
            weatherType: weatherModel.weatherType,
            weatherTypeImageUrl: getImageUrl(from: weatherModel.weatherIconId),
            temperature: String(format: "%.1f°C", weatherModel.temperature),
            description: desc)
        if let highTemperature = weatherModel.highTemperature {
            header.highTemperature = String(format: "High: %.1f°C", highTemperature)
        }
        if let lowTemperature = weatherModel.lowTemperature {
            header.lowTemperature = String(format: "Low: %.1f°C", lowTemperature)
        }
        
        var params: [WeatherDetail.DetailWeather.ViewModel.Param] = []
        if let temp = weatherModel.feelsLikeTemperature {
            params.append(WeatherDetail.DetailWeather.ViewModel.Param(
                            imageIcon: UIImage(systemName: "face.smiling"),
                            title: "Feels Like",
                            detail: String(format: "%.1f°C", temp)))
        }
        if let pressure = weatherModel.pressure {
            params.append(WeatherDetail.DetailWeather.ViewModel.Param(
                            imageIcon: UIImage(systemName: "barometer"),
                            title: "Pressure",
                            detail: "\(pressure) hPa"))
        }
        if let humidity = weatherModel.humidity {
            params.append(WeatherDetail.DetailWeather.ViewModel.Param(
                            imageIcon: UIImage(systemName: "wind"),
                            title: "Humidity",
                            detail: "\(humidity)%"))
        }
        if let cloudiness = weatherModel.cloudiness {
            params.append(WeatherDetail.DetailWeather.ViewModel.Param(
                            imageIcon: UIImage(systemName: "cloud.sun"),
                            title: "Cloudiness",
                            detail: String(format: "%.2f%%", cloudiness)))
        }
        if let sunrise = weatherModel.sunrise {
            params.append(WeatherDetail.DetailWeather.ViewModel.Param(
                            imageIcon: UIImage(systemName: "sunrise"),
                            title: "Sunrise",
                            detail: timeFormatter.string(from: sunrise)))
        }
        if let sunrset = weatherModel.sunset {
            params.append(WeatherDetail.DetailWeather.ViewModel.Param(
                            imageIcon: UIImage(systemName: "sunset"),
                            title: "Sunset",
                            detail: timeFormatter.string(from: sunrset)))
        }
        let viewModel = WeatherDetail.DetailWeather.ViewModel(
            header: header,
            params: params)
        DispatchQueue.main.async {
            self.viewController?.displayDetailWeather(viewModel: viewModel)
        }
    }
    
    private func getImageUrl(from iconId: String?) -> URL? {
        guard let id = iconId else { return nil }
        let urlString = WeatherDetailPresenter.iconUrl + id + "@2x.png"
        return URL(string: urlString)
    }
}
