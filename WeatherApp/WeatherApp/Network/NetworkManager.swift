//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Manisha Sinha on 27/04/26.
//

import Foundation
import Combine

protocol NetworkManaging {
    func request(_ endpoint: URLRequest, isTokenRequired: Bool,
                 params: Parameters?) -> AnyPublisher<JSON, APIErrorModel>
}

final class NetworkManager: NetworkManaging {
    func request(_ endpoint: URLRequest, isTokenRequired: Bool, params: Parameters?) -> AnyPublisher<JSON, APIErrorModel> {
        
        APILogger.logRequest(endpoint)
        
        return URLSession.shared.dataTaskPublisher(for: endpoint)
            .tryMap { output -> JSON in
                APILogger.logResponse(data: output.data,response: output.response,error: nil)
                guard let httpResponse = output.response as? HTTPURLResponse else {
                    throw APIErrorModel(statusCode: -1, message: "Invalid response")
                }
                let statusCode = httpResponse.statusCode
                if (200...299).contains(statusCode) {
                    if let jsonResult = try JSONSerialization.jsonObject(with: output.data) as? JSON {
                        return jsonResult
                    }
                    throw APIErrorModel(statusCode: statusCode, message: "Parsing failed")
                }
                else {
                    let errorJSON = try? JSONSerialization.jsonObject(with: output.data) as? JSON
                    let message = errorJSON?[MESSAGE_KEY] as? String ?? "Something went wrong"
                    throw APIErrorModel(statusCode: statusCode, message: message)
                }
            }
            .mapError { error -> APIErrorModel in
                if let apiError = error as? APIErrorModel { return apiError }
                return APIErrorModel(statusCode: -1, message: error.localizedDescription)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
