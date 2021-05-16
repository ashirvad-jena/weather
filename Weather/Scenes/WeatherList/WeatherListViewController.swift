//
//  WeatherListViewController.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import UIKit

protocol WeatherListDisplayLogic: AnyObject {
    func displayWeathers(viewModel: WeatherListUseCases.ShowWeathers.ViewModel)
    func displayDeletionStatus(status: String)
    func displayReload(viewModel: WeatherListUseCases.UpdateWeather.ViewModel)
}

final class WeatherListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
        
    static let weatherCellHeight: CGFloat = 80
    private var interactor: WeatherListBusinessLogic?
    private var router: WeatherListRouterLogic?
    private var weathers: [WeatherListUseCases.DisplayWeather] = []
    private let refreshControl = UIRefreshControl()
        
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

extension WeatherListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return WeatherListViewController.weatherCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.showWeatherDetail()
    }
}
