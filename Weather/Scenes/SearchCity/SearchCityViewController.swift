//
//  SearchCityViewController.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import UIKit

/// Defines methods to display the UI based on use case
protocol SearchCityDisplayLogic: AnyObject {
    func displayResult(cityName: String)
    func showError(message: String)
}

/// Scene to search for weather based on city name
final class SearchCityViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var interactor: SearchCityBusinessLogic?
    var router: SearchCityRouterLogic?
    
    // MARK: - Setup
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
        let interactor = SearchCityInteractor()
        let presenter = SearchCityPresenter()
        let router = SearchCityRouter()
        viewController.router = router
        router.viewController = viewController
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewObject = viewController
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.showsCancelButton = true
        resultLabel.isHidden = true
        saveButton.isHidden = true
        saveButton.backgroundColor = UIColor(named: "buttonBg")
        saveButton.layer.cornerRadius = saveButton.frame.height/2
        saveButton.setTitleColor(.white, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Button Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        interactor?.saveWeatherModel()
        router?.navigateToWeatherListViewController()
    }
}

// MARK: - SearchCityDisplayLogic
extension SearchCityViewController: SearchCityDisplayLogic {
    func displayResult(cityName: String) {
        resultLabel.isHidden = false
        saveButton.isHidden = false
        resultLabel.text = cityName
    }
    
    func showError(message: String) {
        resultLabel.isHidden = false
        saveButton.isHidden = true
        resultLabel.text = message
    }
}

// MARK: - UISearchBarDelegate
extension SearchCityViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text,
              !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        let request = SearchCityUseCases.FetchWeather.Request(searchCityName: searchBar.text ?? "")
        interactor?.fetchWeatherDetails(for: request)
        searchBar.resignFirstResponder()
        searchBar.text = nil
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        router?.navigateToWeatherListViewController()
    }
}
