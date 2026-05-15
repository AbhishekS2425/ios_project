//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Manisha Sinha on 27/04/26.
//

import Foundation
import Combine

protocol WeatherServiceProtocol {
    func fetchWeather(city: String) -> AnyPublisher<WeatherResponse, APIErrorModel>
}

final class WeatherService: WeatherServiceProtocol {
    
    private let networkManager: NetworkManaging
    private let apiKey = "bbd126e1802f786a34dde503debe4c5b"
    
    init(networkManager: NetworkManaging = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchWeather(city: String) -> AnyPublisher<WeatherResponse, APIErrorModel> {
        let urlString = urn(city: city, apiKey: apiKey)
        
        guard let url = URL(string: urlString) else { return Fail(
            error: APIErrorModel(
                statusCode: -1,
                message: "Invalid URL"
            )
        )
        .eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        return networkManager.request(request, isTokenRequired: false, params: nil)
            .tryMap { json in
                return WeatherResponse.convertedWeatherResponse(json: json)
            }
            .mapError { error in
                
                if let apiError = error as? APIErrorModel {
                    return apiError
                }
                
                return APIErrorModel(
                    statusCode: -1,
                    message: error.localizedDescription
                )
            }
            .eraseToAnyPublisher()
    }
}

extension WeatherService {
    func urn(city: String, apiKey: String) -> String {
        "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
    }
}
