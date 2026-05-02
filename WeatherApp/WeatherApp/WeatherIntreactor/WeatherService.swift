//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Manisha Sinha on 27/04/26.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(city: String,
                      success: @escaping (_ weatherResponse: WeatherResponse) -> Void, failure: @escaping (_ error: APIErrorModel) -> Void)
}

final class WeatherService: WeatherServiceProtocol {
    
    private let networkManager: NetworkManaging
    private let apiKey = "bbd126e1802f786a34dde503debe4c5b"
    
    init(networkManager: NetworkManaging = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchWeather(city: String,
                      success: @escaping (_ weatherResponse: WeatherResponse) -> Void, failure: @escaping (_ error: APIErrorModel) -> Void) {
        
        let urlString = urn(city: city, apiKey: apiKey)
        
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        networkManager.request(request, isTokenRequired: false, params: nil) { result in
            let weatherResponse = WeatherResponse.convertedWeatherResponse(json: result)
            success(weatherResponse)
            
        } failure: { error in
            failure(error)
        }
    }
}

extension WeatherService {
    func urn(city: String, apiKey: String) -> String {
        "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
    }
}
