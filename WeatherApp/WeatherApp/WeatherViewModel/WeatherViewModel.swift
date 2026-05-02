//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Manisha Sinha on 27/04/26.
//

import Foundation

final class WeatherViewModel {
    
    private let service: WeatherServiceProtocol
    
    var temperature: String = ""
    var description: String = ""
    var weatherType: String = ""
    var latitude: String = ""
    var longitude: String = ""
    var errorMessage: String = ""
    
    init(service: WeatherServiceProtocol = WeatherService()) {
        self.service = service
    }
    
    func getWeather(city: String, completion: @escaping () -> Void) {
        service.fetchWeather(city: city) { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.updateUI(with: data)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
                completion()
            }
        }
    }
    
    private func updateUI(with data: WeatherResponse) {
        latitude = "\(data.coord?.lat ?? 0.0)"
        longitude = "\(data.coord?.lon ?? 0.0)"
        temperature = "\(data.main?.temp ?? 0.0)°C"
        description = data.weather.first?.description ?? ""
        weatherType = data.weather.first?.main ?? ""
    }
}
