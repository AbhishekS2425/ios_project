//
//  ApiLogger.swift
//  WeatherApp
//
//  Created by Manisha Sinha on 27/04/26.
//

import Foundation

enum APILogger {
    
    static func logRequest(_ request: URLRequest) {
        print("\n📡 ===== API REQUEST =====")
        
        if let url = request.url?.absoluteString {
            print("🔗 URL:", url)
        }
        
        print("📌 Method:", request.httpMethod ?? "GET")
        
        if let headers = request.allHTTPHeaderFields {
            print("📋 Headers:", headers)
        }
        
        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            print("📦 Payload:", bodyString)
        }
    }
    
    static func logResponse(data: Data?, response: URLResponse?, error: Error?) {
        print("\n📥 ===== API RESPONSE =====")
        
        if let httpResponse = response as? HTTPURLResponse {
            print("📊 Status Code:", httpResponse.statusCode)
        }
        
        if let error = error {
            print("❌ Error:", error.localizedDescription)
        }
        
        if let data = data,
           let json = String(data: data, encoding: .utf8) {
            print("📦 Response Body:\n", json)
        }
        
        print("📥 =======================\n")
    }
}
