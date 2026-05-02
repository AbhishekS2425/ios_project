//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Manisha Sinha on 27/04/26.
//

import Foundation

protocol NetworkManaging {
    func request<T>(_ endpoint: URLRequest,
                               completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkManager: NetworkManaging {
    
    func request<T>(_ endpoint: URLRequest,
                               completion: @escaping (Result<T, Error>) -> Void) {
        
        APILogger.logRequest(endpoint)
        let task = URLSession.shared.dataTask(with: endpoint) { data, response, error in
            
            APILogger.logResponse(data: data, response: response, error: error)
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  let data = data else {
                completion(.failure(NSError(domain: "InvalidResponse", code: -1)))
                return
            }
            
            let statusCode = httpResponse.statusCode
            
            if (200...299).contains(statusCode) {
                
                if let jsonResult = try? JSONSerialization.jsonObject(with: data) as? JSON {
                    var jsonData: WeatherResponse = WeatherResponse()
                    jsonData = WeatherResponse.convertedWeatherResponse(json: jsonResult)
                    completion(.success(jsonData as! T))
                    return
                }
                completion(.failure(NSError(domain: "ParseError", code: -2)))
                return
            }
            
            let errorJSON = try? JSONSerialization.jsonObject(with: data) as? JSON
            let message = errorJSON?["message"] as? String ?? "Something went wrong"
            
            let apiError = NSError(
                domain: "APIError",
                code: statusCode,
                userInfo: [NSLocalizedDescriptionKey: message]
            )
            completion(.failure(apiError))
        }
        
        task.resume()
    }
}
