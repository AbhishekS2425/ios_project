//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Manisha Sinha on 27/04/26.
//

import Foundation


protocol NetworkManaging {
    func request<T: Decodable>(_ endpoint: URLRequest,
                               completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkManager: NetworkManaging {
    
    func request<T: Decodable>(_ endpoint: URLRequest,
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
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
                return
            }
            
            let apiError = try? JSONDecoder().decode(APIErrorResponse.self, from: data)
            
            let message = apiError?.message ?? "Something went wrong"
            
            let error = NSError(
                domain: "APIError",
                code: statusCode,
                userInfo: [NSLocalizedDescriptionKey: message]
            )
            completion(.failure(error))
        }
        
        task.resume()
    }
}
