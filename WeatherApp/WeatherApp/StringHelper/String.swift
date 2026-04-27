//
//  String.swift
//  WeatherApp
//
//  Created by Manisha Sinha on 27/04/26.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    static func stringValue(_ value: Any?) -> String {
            guard let value = value else { return "" }
            
            if let str = value as? String {
                return str
            }
            
            if let int = value as? Int {
                return String(int)
            }
            
            if let double = value as? Double {
                return String(double)
            }
            
            return "\(value)"
        }
}
