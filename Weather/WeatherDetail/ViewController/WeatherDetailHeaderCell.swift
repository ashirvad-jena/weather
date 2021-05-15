//
//  WeatherDetailHeaderCell.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import UIKit

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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
