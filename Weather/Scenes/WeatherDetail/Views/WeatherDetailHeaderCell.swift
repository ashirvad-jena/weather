//
//  WeatherDetailHeaderCell.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import UIKit
import SDWebImage

class WeatherDetailHeaderCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var weatherTypeIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let reuseIdentifier = "WeatherDetailHeaderCell"
    
    var header: WeatherDetailUseCases.DetailWeather.ViewModel.Header? {
        didSet {
            cityNameLabel.text = header?.cityName
            weatherTypeLabel.text = header?.weatherType
            weatherTypeIcon.sd_setImage(with: header?.weatherTypeImageUrl, placeholderImage: UIImage(named: "defaultWeatherIcon"))
            temperatureLabel.text = header?.temperature
            if let highTemp = header?.highTemperature {
                highTemperatureLabel.text = highTemp
            } else {
                highTemperatureLabel.isHidden = true
            }
            if let lowTemp = header?.lowTemperature {
                lowTemperatureLabel.text = lowTemp
            } else {
                lowTemperatureLabel.isHidden = true
            }
            descriptionLabel.text = header?.description
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        weatherTypeIcon.layer.masksToBounds = true
        weatherTypeIcon.backgroundColor = .lightGray
        weatherTypeIcon.layer.cornerRadius = 4
        weatherTypeIcon.layer.borderWidth = 2
        weatherTypeIcon.layer.borderColor = UIColor.gray.cgColor
    }
}
