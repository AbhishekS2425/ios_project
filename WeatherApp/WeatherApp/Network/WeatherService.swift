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
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        
        networkManager.request(request, completion: completion)
    }
}
