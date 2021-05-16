//
//  WeatherListRouter.swift
//  Weather
//
//  Created by Ashirvad Jena on 16/05/21.
//

import Foundation

protocol WeatherListRouterLogic {
    func showSearchCity()
    func showWeatherDetail()
}

protocol WeatherListDataPassing {
    var dataStore: WeatherListDataSource? { get }
}

class WeatherListRouter: WeatherListRouterLogic, WeatherListDataPassing {
        
    var dataStore: WeatherListDataSource?
    weak var viewController: WeatherListViewController?
    
    func showSearchCity() {
        let searchVC = SearchCityViewController(nibName: "SearchCityViewController", bundle: nil)
        viewController?.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    func showWeatherDetail() {
        let weatherDetailVC = WeatherDetailViewController(nibName: "WeatherDetailViewController", bundle: nil)
        var destinationDataSource = weatherDetailVC.router?.dataSource
        passDataToDetailWeather(source: dataStore, destination: &destinationDataSource)
        viewController?.navigationController?.pushViewController(weatherDetailVC, animated: true)
    }
    
    private func passDataToDetailWeather(source: WeatherListDataSource?, destination: inout WeatherDetailDataSource?) {
        guard let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row else {
            preconditionFailure("Selected index shouldn't be nil")
        }
        destination?.weatherModel = source?.weathers[selectedRow]
    }
}
