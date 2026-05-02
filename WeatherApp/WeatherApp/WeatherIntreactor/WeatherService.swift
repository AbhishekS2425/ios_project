//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Manisha Sinha on 27/04/26.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(city: String,
                      completion: @escaping (Result<WeatherResponse, Error>) -> Void)
}

final class WeatherService: WeatherServiceProtocol {
    
    private let networkManager: NetworkManaging
    private let apiKey = "bbd126e1802f786a34dde503debe4c5b"
    
    init(networkManager: NetworkManaging = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchWeather(city: String,
                      completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        let urlString = urn(city: city, apiKey: apiKey)
        
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        networkManager.request(request) {(result: Result<JSON, Error>) in
            switch result {
            case .success(let json):
                let weather = WeatherResponse.convertedWeatherResponse(json: json)
                completion(.success(weather))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension WeatherService {
    func urn(city: String, apiKey: String) -> String {
        "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
    }
}
