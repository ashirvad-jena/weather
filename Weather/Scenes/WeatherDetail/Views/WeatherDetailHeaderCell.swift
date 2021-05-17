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
    @IBOutlet weak var animationContainerView: UIView!
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud3: UIImageView!
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
        
        addAnimation()
    }
    
    // MARK: - Background Animation
    private func addAnimation() {
        let fadeIn = CABasicAnimation(keyPath: "opacity")
        fadeIn.fromValue = 0.0
        fadeIn.toValue = 1.0
        fadeIn.duration = 0.5
        fadeIn.fillMode = .backwards
        fadeIn.beginTime = CACurrentMediaTime() + 0.5
        cloud1.layer.add(fadeIn, forKey: nil)

        fadeIn.beginTime = CACurrentMediaTime() + 0.7
        cloud2.layer.add(fadeIn, forKey: nil)

        fadeIn.beginTime = CACurrentMediaTime() + 0.9
        cloud3.layer.add(fadeIn, forKey: nil)
        
        animateCloud(cloud1)
        animateCloud(cloud2)
        animateCloud(cloud3)
    }
    
    func animateCloud(_ cloud: UIImageView) {
        let cloudSpeed = 60.0 / frame.size.width
        let duration = (frame.size.width - cloud.frame.origin.x) * cloudSpeed
        UIView.animate(
            withDuration: TimeInterval(duration), delay: 0.0, options: .curveLinear,
            animations: {
                cloud.frame.origin.x = self.frame.size.width
            },
            completion: {_ in
                cloud.frame.origin.x = -cloud.frame.size.width
                self.animateCloud(cloud)
            }
        )
    }
}
