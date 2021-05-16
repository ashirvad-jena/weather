//
//  WeatherDetailRouter.swift
//  Weather
//
//  Created by Ashirvad Jena on 16/05/21.
//

import Foundation

protocol WeatherDetailRouterLogic {
    func routeToWeathersList()
}

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
