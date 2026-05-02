//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Manisha Sinha on 27/04/26.
//

import Foundation

protocol NetworkManaging {
    func request(_ endpoint: URLRequest, isTokenRequired: Bool,
                    params: Parameters?,
                            success: @escaping (_ result: JSON) -> Void,
                            failure: @escaping (_ error: APIErrorModel) -> Void)
}

final class NetworkManager: NetworkManaging {
    
    func request(_ endpoint: URLRequest, isTokenRequired: Bool = false,
                    params: Parameters? = nil,
                    success: @escaping (_ result: JSON) -> Void,
                    failure: @escaping (_ error: APIErrorModel) -> Void) {
        
        APILogger.logRequest(endpoint)
        let task = URLSession.shared.dataTask(with: endpoint) { data, response, error in
            
            APILogger.logResponse(data: data, response: response, error: error)
            
            if let error = error {
                failure(APIErrorModel(statusCode: -1, message: error.localizedDescription))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  let data = data else {
                failure(APIErrorModel(statusCode: -1, message: "Invalid response"))
                return
            }
            
            let statusCode = httpResponse.statusCode
            
            if (200...299).contains(statusCode) {
                
                if let jsonResult = try? JSONSerialization.jsonObject(with: data) as? JSON {
                    success(jsonResult)
                    return
                }
                let apiError = APIErrorModel(
                    statusCode: statusCode,
                    message: "Something went wrong"
                )
                failure(apiError)
                return
            }
            else {
                let errorJSON = try? JSONSerialization.jsonObject(with: data) as? JSON
                let message = errorJSON?[MESSAGE_KEY] as? String ?? "Something went wrong"
                
                let apiError = APIErrorModel(
                    statusCode: statusCode,
                    message: message
                )
                failure(apiError)
            }
        }
        
        task.resume()
    }
}
