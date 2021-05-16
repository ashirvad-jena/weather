//
//  WeatherDetailPresenter.swift
//  Weather
//
//  Created by Ashirvad Jena on 16/05/21.
//

import Foundation

protocol WeatherDetailPresentationLogic {
    func showWeatherDetail(response: WeatherDetail.DetailWeather.Response)
}

class WeatherDetailPresenter: WeatherDetailPresentationLogic {
    
    weak var viewController: WeatherDetailViewController?
    
    static let iconUrl = "http://openweathermap.org/img/wn/"
    
    private var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
       return formatter
    }()
    
    func showWeatherDetail(response: WeatherDetail.DetailWeather.Response) {
        guard let weatherModel = response.weatherModel else { return }
        var header = WeatherDetail.DetailWeather.ViewModel.Header(
            cityName: weatherModel.cityName,
            weatherType: weatherModel.weatherType,
            weatherTypeImageUrl: getImageUrl(from: weatherModel.weatherIconId),
            temperature: String(format: "%.1f", weatherModel.temperature),
            lowTemperature: "",
            description: "")
        header.highTemperature = String(format: "%.1f", weatherModel.highTemperature!)
        
        
        
        var params: [WeatherDetail.DetailWeather.ViewModel.Param] = []
        if let temp = weatherModel.feelsLikeTemperature {
            params.append(WeatherDetail.DetailWeather.ViewModel.Param(
                            imageIcon: nil,
                            title: "Feels Like",
                            detail: String(format: "%.1f", temp)))
        }
        if let pressure = weatherModel.pressure {
            params.append(WeatherDetail.DetailWeather.ViewModel.Param(
                            imageIcon: nil,
                            title: "Pressure",
                            detail: "\(pressure) hPa"))
        }
        if let humidity = weatherModel.humidity {
            params.append(WeatherDetail.DetailWeather.ViewModel.Param(
                            imageIcon: nil,
                            title: "Humidity",
                            detail: "\(humidity)%"))
        }
        if let cloudiness = weatherModel.cloudiness {
            params.append(WeatherDetail.DetailWeather.ViewModel.Param(
                            imageIcon: nil,
                            title: "Cloudness",
                            detail: String(format: "%.2f%", cloudiness*100)))
        }
        if let sunrise = weatherModel.sunrise {
            params.append(WeatherDetail.DetailWeather.ViewModel.Param(
                            imageIcon: nil,
                            title: "Sunrise",
                            detail: timeFormatter.string(from: sunrise)))
        }
        if let sunrset = weatherModel.sunset {
            params.append(WeatherDetail.DetailWeather.ViewModel.Param(
                            imageIcon: nil,
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
