//
//  WeatherAPI.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import Foundation

struct WeatherAPI: FetchCityWeatherProtocol {
    
    static let apiKey = "c609091a0a8fd1c5dbc2ce965aa09db1"
    
    func fetchWeatherFromApi(for searchName: String, completionHandler: @escaping (ServerWeatherModel?) -> Void) {
        var responseModel: ServerWeatherModel?
        defer {
            completionHandler(responseModel)
        }
        guard !searchName.isEmpty else { return }
        let urlString = getUrlString(for: searchName)
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil,
                  let data = data else { return }
            do {
                let serverModel = try JSONDecoder().decode(ServerWeatherModel.self, from: data)
                responseModel = serverModel
                
            } catch {
                debugPrint(error.localizedDescription)
                return
            }
        }
        task.resume()
    }
    
    private func getUrlString(for city: String) -> String {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(WeatherAPI.apiKey)&units=metric"
        return urlString
    }
}
