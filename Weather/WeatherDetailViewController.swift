//
//  WeatherDetailViewController.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    static let headerCellHeight: CGFloat = 200
    static let infoCellHeight: CGFloat = 55
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "WeatherDetailHeaderCell", bundle: nil), forCellReuseIdentifier: WeatherDetailHeaderCell.reuseIdentifier)
        tableView.register(UINib(nibName: "WeatherDetailInfoCell", bundle: nil), forCellReuseIdentifier: WeatherDetailInfoCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
    }
}

extension WeatherDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 5
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailHeaderCell.reuseIdentifier, for: indexPath) as? WeatherDetailHeaderCell else { return UITableViewCell() }
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailInfoCell.reuseIdentifier, for: indexPath) as? WeatherDetailInfoCell else { return UITableViewCell() }
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

extension WeatherDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return WeatherDetailViewController.headerCellHeight
            
        case 1:
            return WeatherDetailViewController.infoCellHeight
            
        default:
            return 0
        }
    }
}
