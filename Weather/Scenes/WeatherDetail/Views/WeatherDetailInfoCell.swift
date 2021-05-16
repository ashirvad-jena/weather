//
//  WeatherDetailInfoCell.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import UIKit

class WeatherDetailInfoCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var infoIcon: UIImageView!
    @IBOutlet weak var infoDescriptionLabel: UILabel!
    
    static let reuseIdentifier = "WeatherDetailInfoCell"
    
    var param: WeatherDetailUseCases.DetailWeather.ViewModel.Param? {
        didSet {
            infoIcon.image = param?.imageIcon
            infoTitleLabel.text = param?.title
            infoDescriptionLabel.text = param?.detail
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        infoIcon.tintColor = UIColor(named: "iconTint")
    }
}
