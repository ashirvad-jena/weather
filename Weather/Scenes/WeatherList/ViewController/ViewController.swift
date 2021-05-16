//
//  ViewController.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    static let weatherCellHeight: CGFloat = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellReuseIdentifier: WeatherCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showSearch))
    }
    
    @objc func showSearch() {
        let searchVC = SearchCityViewController(nibName: "SearchCityViewController", bundle: nil)
        navigationController?.present(searchVC, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.reuseIdentifier, for: indexPath) as? WeatherCell else { return UITableViewCell() }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ViewController.weatherCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherDetailVC = WeatherDetailViewController(nibName: "WeatherDetailViewController", bundle: nil)
        navigationController?.pushViewController(weatherDetailVC, animated: true)
    }
}

