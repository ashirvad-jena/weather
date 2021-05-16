//
//  WeatherListViewController.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import UIKit

protocol WeatherListDisplayLogic: AnyObject {
    func displayWeathers(viewModel: WeatherList.ShowWeathers.ViewModel)
}

class WeatherListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    static let weatherCellHeight: CGFloat = 80
    var interactor: WeatherListBusinessLogic?
    var router: WeatherListRouterLogic?
    var weathers: [WeatherList.ShowWeathers.ViewModel.DisplayWeather] = []
        
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = WeatherListInteractor()
        let presenter = WeatherListPresenter()
        let router = WeatherListRouter()
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewObject = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellReuseIdentifier: WeatherCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearch))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchWeathers()
    }
    
    private func fetchWeathers() {
        interactor?.fetchWeathers()
    }
    
    @objc func showSearch() {
        router?.showSearchCity()
    }
}

extension WeatherListViewController: WeatherListDisplayLogic {
    
    func displayWeathers(viewModel: WeatherList.ShowWeathers.ViewModel) {
        weathers = viewModel.displayWeathers
        tableView.reloadData()
    }
}

extension WeatherListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.reuseIdentifier, for: indexPath) as? WeatherCell else { return UITableViewCell() }
        cell.weather = weathers[indexPath.row]
        return cell
    }
}

extension WeatherListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return WeatherListViewController.weatherCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.showWeatherDetail()
    }
}

