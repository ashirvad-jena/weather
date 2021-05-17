//
//  WeatherDetailRouter.swift
//  Weather
//
//  Created by Ashirvad Jena on 16/05/21.
//

import Foundation

/// Defines routing methods for `detail weather` scene
protocol WeatherDetailRouterLogic {
    func routeToWeathersList()
}

/// Holds the data received from other scenes
protocol WeatherDetailDataPassing {
    var dataSource: WeatherDetailDataSource? { get }
}

class WeatherDetailRouter: WeatherDetailRouterLogic, WeatherDetailDataPassing {
    
    weak var viewController: WeatherDetailViewController?
    var dataSource: WeatherDetailDataSource?
    
    func routeToWeathersList() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
