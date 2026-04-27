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
    
    static func takeAsStringAlways(_ value: Any?) -> String {
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

extension Int {
    
    static func takeAsIntAlways(_ value: Any?) -> Int {
        guard let value = value else { return 0 }
        
        if let string = value as? String {
            return Int(string) ?? 0
        }
        
        if let int = value as? Int {
            return int
        }
        
        if let double = value as? Double {
            return Int(double)
        }
        
        return 0
    }
}

extension Bool {
    
    static func takeAsBoolAlways(_ value: Any?) -> Bool {
        guard let value = value else { return false }
        
        if let string = value as? String {
            return Bool(string) ?? false
        }
        
        if let int = value as? Int {
            return int != 0
        }
        
        return false
    }
}
