//
//  SearchCityViewController.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import UIKit

protocol SearchCityDisplayLogic: AnyObject {
    func displayResult(string: String)
}

class SearchCityViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension SearchCityViewController: SearchCityDisplayLogic {
    func displayResult(string: String) {
        resultLabel.text = string
    }
}
