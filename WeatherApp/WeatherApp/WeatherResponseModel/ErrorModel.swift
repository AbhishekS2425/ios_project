//
//  ErrorModel.swift
//  WeatherApp
//
//  Created by Manisha Sinha on 02/05/26.
//

import Foundation

class APIErrorModel: NSObject, LocalizedError {
    let statusCode: Int
    let message: String
    
    init(statusCode: Int, message: String) {
        self.statusCode = statusCode
        self.message = message
    }
    
    var errorDescription: String? {
        return message
    }
}
