//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Manisha Sinha on 27/04/26.
//

import Foundation
import Combine

final class WeatherViewModel {
    
    private let service: WeatherServiceProtocol
    
    var temperature: String = ""
    var description: String = ""
    var weatherType: String = ""
    var latitude: String = ""
    var longitude: String = ""
    var errorMessage: String = ""
    private var cancellables = Set<AnyCancellable>()

    init(service: WeatherServiceProtocol = WeatherService()) {
        self.service = service
    }
    
    func getWeather(city: String, completion: @escaping () -> Void)  {
        service.fetchWeather(city: city)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completionResult in
                
                switch completionResult {
                    
                case .finished:
                    print("API Success")
                    
                case .failure(let error):
                    self?.errorMessage = error.message
                    completion()
                }
                
            } receiveValue: { [weak self] weatherResponse in
                
                self?.updateUI(with: weatherResponse)
                completion()
            }
            .store(in: &cancellables)
    }
    
    private func updateUI(with data: WeatherResponse) {
        latitude = "\(data.coord?.lat ?? 0.0)"
        longitude = "\(data.coord?.lon ?? 0.0)"
        temperature = "\(data.main?.temp ?? 0.0)°C"
        description = data.weather.first?.description ?? ""
        weatherType = data.weather.first?.main ?? ""
    }
}
