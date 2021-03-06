//
//  WeatherDetailViewController.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import UIKit

protocol WeatherDetailDisplayLogic {
    func displayDetailWeather(viewModel: WeatherDetailUseCases.DetailWeather.ViewModel)
}

final class WeatherDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: TableViewCell's height
    static let headerCellHeight: CGFloat = 200
    static let infoCellHeight: CGFloat = 55
    
    var router: (WeatherDetailRouterLogic & WeatherDetailDataPassing)?
    var interactor: WeatherDetailBusinessLogic?
    
    // MARK: ViewModel for UI
    private var detailWeather: WeatherDetailUseCases.DetailWeather.ViewModel.DisplayWeather?
    
    // MARK: Setup
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let viewController = self
        let interactor = WeatherDetailInteractor()
        let presenter = WeatherDetailPresenter()
        let router = WeatherDetailRouter()
        viewController.router = router
        router.viewController = viewController
        router.dataSource = interactor
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "WeatherDetailHeaderCell", bundle: nil), forCellReuseIdentifier: WeatherDetailHeaderCell.reuseIdentifier)
        tableView.register(UINib(nibName: "WeatherDetailInfoCell", bundle: nil), forCellReuseIdentifier: WeatherDetailInfoCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        navigationItem.title = "Weather Details"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchWeatherDetail()
    }
    
    private func fetchWeatherDetail() {
        interactor?.getDetailWeather()
    }
}

// MARK: - WeatherDetailDisplayLogic
extension WeatherDetailViewController: WeatherDetailDisplayLogic {
    func displayDetailWeather(viewModel: WeatherDetailUseCases.DetailWeather.ViewModel) {
        detailWeather = viewModel.displayWeather
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension WeatherDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let detailWeather = detailWeather else { return 0 }
        switch section {
        case 0:
            return 1
        case 1:
            return detailWeather.params.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailHeaderCell.reuseIdentifier, for: indexPath) as? WeatherDetailHeaderCell else { return UITableViewCell() }
            cell.header = detailWeather?.header
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailInfoCell.reuseIdentifier, for: indexPath) as? WeatherDetailInfoCell else { return UITableViewCell() }
            if let params = detailWeather?.params {
                cell.param = params[indexPath.row]
            }
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
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
