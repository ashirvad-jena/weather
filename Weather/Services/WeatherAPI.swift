//
//  WeatherAPI.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import Foundation

struct WeatherAPI: FetchCityWeatherProtocol {
    
    static let apiKey = "c609091a0a8fd1c5dbc2ce965aa09db1"
    
    // NOTE: Sometimes, upon multiple fetch the dt shows less time than the previous fetch.
    func fetchWeatherFromApi(for searchName: String, completionHandler: @escaping (ServerWeatherModel?, Error?) -> Void) {
        guard let urlRequest = getUrlRequest(for: searchName) else {
            completionHandler(nil, WeatherError.invalidCityName)
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil,
                  let data = data else {
                completionHandler(nil, WeatherError.fetchFailure)
                return
            }
            do {
                // To handle error inside success response
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                if let jsonDict = jsonObject as? [String: Any],
                   let errorCode = jsonDict["cod"] as? String,
                   errorCode == "404" {
                    completionHandler(nil, WeatherError.invalidCityName)
                    
                } else {
                    let serverModel = try JSONDecoder().decode(ServerWeatherModel.self, from: data)
                    completionHandler(serverModel, nil)
                }
                
            } catch {
                debugPrint(error.localizedDescription)
                // Ovverriding with custom error for user friendly message
                completionHandler(nil, WeatherError.unknown)
                return
            }
        }
        task.resume()
    }
    
    private func getUrlRequest(for city: String) -> URLRequest? {
        guard !city.isEmpty else { return nil }
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(WeatherAPI.apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return nil }
        return URLRequest(url: url)
    }
}
