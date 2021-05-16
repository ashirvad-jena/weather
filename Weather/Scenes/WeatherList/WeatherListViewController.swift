//
//  WeatherListViewController.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import UIKit

/// This protocol defines the  display behaviour of all use cases for list of weathers
protocol WeatherListDisplayLogic: AnyObject {
    /// Provides a viewModel corresponding to the UI of a cell to show brief info about a city's weather
    /// - Parameter viewModel:
    func displayWeathers(viewModel: WeatherListUseCases.ShowWeathers.ViewModel)
    /// Provides the status after a deletion operation id performed on a city's weather
    /// - Parameter status: information to be displayed to user
    func displayDeletionStatus(status: String)
    /// Provides a viewModel corresponding to the UI of a cell after updating a particular city's weather
    /// - Parameter viewModel:
    func displayReload(viewModel: WeatherListUseCases.UpdateWeather.ViewModel)
}

final class WeatherListViewController: UIViewController {

    // MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
        
    static let weatherCellHeight: CGFloat = 80
    private var interactor: WeatherListBusinessLogic?
    private var router: WeatherListRouterLogic?
    private var weathers: [WeatherListUseCases.DisplayWeather] = []
    private let refreshControl = UIRefreshControl()
     
    // MARK: - Setup
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Lifecycle Methods
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
        emptyLabel.isHidden = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearch))
        navigationItem.title = "Cities"
        refreshControl.addTarget(self, action: #selector(updateWeatherInfo), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchWeathers()
    }
    
    private func fetchWeathers() {
        interactor?.fetchWeathers()
    }
    
    @objc private func showSearch() {
        router?.showSearchCity()
    }
    
    @objc private func updateWeatherInfo() {
        interactor?.updateWeathers()
    }
}

extension WeatherListViewController: WeatherListDisplayLogic {
    
    func displayWeathers(viewModel: WeatherListUseCases.ShowWeathers.ViewModel) {
        weathers = viewModel.displayWeathers
        emptyLabel.isHidden = !weathers.isEmpty
        tableView.reloadData()
    }
    
    func displayDeletionStatus(status: String) {
        let alertController = UIAlertController(title: nil, message: status, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        navigationController?.present(alertController, animated: true)
        tableView.reloadData()
    }
    
    func displayReload(viewModel: WeatherListUseCases.UpdateWeather.ViewModel) {
        weathers = viewModel.displayWeathers
        tableView.reloadRows(at: [viewModel.indexPath], with: .automatic)
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
}

// MARK: - UITableViewDataSource
extension WeatherListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.reuseIdentifier, for: indexPath) as? WeatherCell else { return UITableViewCell() }
        cell.weather = weathers[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        interactor?.deleteWeather(at: indexPath.row)
    }
}

// MARK: - UITableViewDelegate
extension WeatherListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return WeatherListViewController.weatherCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.showWeatherDetail()
    }
}
