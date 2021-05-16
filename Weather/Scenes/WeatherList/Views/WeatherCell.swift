//
//  WeatherCell.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    static let reuseIdentifier = "WeatherCell"
    
    var weather: WeatherListUseCases.ShowWeathers.ViewModel.DisplayWeather? {
        didSet {
            dateLabel.text = weather?.date
            cityNameLabel.text = weather?.city
            temperatureLabel.text = weather?.temperature
        }
    }
}
