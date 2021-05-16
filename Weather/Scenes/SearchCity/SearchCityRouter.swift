//
//  SearchCityRouter.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import Foundation

protocol SearchCityRouterLogic {
    func navigateToWeatherListViewController()
}

class SearchCityRouter: SearchCityRouterLogic {
    
    weak var viewController: SearchCityViewController?
    
    func navigateToWeatherListViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
