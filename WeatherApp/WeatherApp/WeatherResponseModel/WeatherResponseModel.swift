//
//  WeatherResponseModel.swift
//  WeatherApp
//
//  Created by Manisha Sinha on 27/04/26.

import Foundation

// MARK: - Welcome
class WeatherResponse: NSObject {
    var coord: Coord?
    var weather: [Weather] = [Weather]()
    var base: String?
    var main: Main?
    var visibility: Int?
    var wind: Wind?
    var clouds: Clouds?
    var dt: Int?
    var sys: Sys?
    var timezone: Int?
    var id: Int?
    var name: String?
    var cod: Int?
    
    static func convertedWeatherResponse(json: JSON) -> WeatherResponse {
        let weatherResponse = WeatherResponse()
        if let coordJSON = json["coord"] as? JSON {
            weatherResponse.coord = Coord.convertedCoord(json: coordJSON)
        }
        if let weatherArray = json["weather"] as? [JSON] {
            weatherResponse.weather = weatherArray.map { Weather.convertedWeather(json: $0) }
        }
        if let base = json["base"] as? String {
            weatherResponse.base = String.takeAsStringAlways(base)
        }
        if let mainJSON = json["main"] as? JSON {
            weatherResponse.main = Main.convertedMain(json: mainJSON)
        }
        if let visibility = json["visibility"] as? Int {
            weatherResponse.visibility = Int.takeAsIntAlways(visibility)
        }
        if let windJSON = json["wind"] as? JSON {
            weatherResponse.wind = Wind.convertedWind(json: windJSON)
        }
        if let cloudsJSON = json["clouds"] as? JSON {
            weatherResponse.clouds = Clouds.convertedCloud(json: cloudsJSON)
        }
        weatherResponse.dt = json["dt"] as? Int
        if let sysJSON = json["sys"] as? JSON {
            weatherResponse.sys = Sys.convertedSys(json: sysJSON)
        }
        if let timezone = json["timezone"] as? Int {
            weatherResponse.timezone = Int.takeAsIntAlways(timezone)
        }
        if let idValue = json["id"] as? Int {
            weatherResponse.id = Int.takeAsIntAlways(idValue)
        }
        if let name = json["name"] as? String {
            weatherResponse.name = String.takeAsStringAlways(name)
        }
        if let codValue = json["cod"] as? Int {
            weatherResponse.cod = Int.takeAsIntAlways(codValue)
        }
        return weatherResponse
    }
}

// MARK: - Coord
class Coord: NSObject {
    var lon: Double?
    var lat: Double?
    
    static func convertedCoord(json: JSON) -> Coord {
        let coordData = Coord()
        if let lon = json["lon"] as? Double {
            coordData.lon = Double.takeAsDoubleAlways(lon)
        }
        if let lat = json["lat"] as? Double {
            coordData.lat = Double.takeAsDoubleAlways(lat)
        }
        return coordData
    }
}

// MARK: - Weather
class Weather: NSObject {
    var id: Int?
    var main: String?
    var descriptionVal: String?
    var icon: String?
    
    static func convertedWeather(json: JSON) -> Weather {
        let weatherData = Weather()
        if let idValue = json["id"] as? Int {
            weatherData.id = Int.takeAsIntAlways(idValue)
        }
        if let mainVal = json["main"] as? String {
            weatherData.main = String.takeAsStringAlways(mainVal)
        }
        if let descriptionVal = json["description"] as? String {
            weatherData.descriptionVal = String.takeAsStringAlways(descriptionVal)
        }
        if let iconVal = json["icon"] as? String {
            weatherData.icon = String.takeAsStringAlways(iconVal)
        }
        return weatherData
    }
}

// MARK: - Main
class Main: NSObject {
    var temp: Double?
    var feelsLike: Double?
    var tempMin: Double?
    var tempMax: Double?
    var pressure: Int?
    var humidity: Int?
    var seaLevel: Int?
    var grndLevel: Int?
    
    static func convertedMain(json: JSON) -> Main {
        let mainData = Main()
        if let temp = json["temp"] as? Double {
            mainData.temp = Double.takeAsDoubleAlways(temp)
        }
        if let feelsLike = json["feels_like"] as? Double {
            mainData.feelsLike = Double.takeAsDoubleAlways(feelsLike)
        }
        if let tempMin = json["temp_min"] as? Double {
            mainData.tempMin = Double.takeAsDoubleAlways(tempMin)
        }
        if let tempMax = json["temp_max"] as? Double {
            mainData.tempMax = Double.takeAsDoubleAlways(tempMax)
        }
        if let pressure = json["pressure"] as? Int {
            mainData.pressure = Int.takeAsIntAlways(pressure)
        }
        if let humidity = json["humidity"] as? Int {
            mainData.humidity = Int.takeAsIntAlways(humidity)
        }
        if let seaLevel = json["sea_level"] as? Int {
            mainData.seaLevel = Int.takeAsIntAlways(seaLevel)
        }
        if let grndLevel = json["grnd_level"] as? Int {
            mainData.grndLevel = Int.takeAsIntAlways(grndLevel)
        }
        return mainData
    }
}

// MARK: - Wind
class Wind: NSObject {
    var speed: Double?
    var deg: Int?
    
    static func convertedWind(json: JSON) -> Wind {
        let WindData = Wind()
        if let speed = json["speed"] as? Double {
            WindData.speed = Double.takeAsDoubleAlways(speed)
        }
        if let deg = json["deg"] as? Int {
            WindData.deg = Int.takeAsIntAlways(deg)
        }
        return WindData
    }
}

// MARK: - Clouds
class Clouds: NSObject {
    var all: Int?
    
    static func convertedCloud(json: JSON) -> Clouds {
        let CloudsData = Clouds()
        if let all = json["all"] as? Int {
            CloudsData.all = Int.takeAsIntAlways(all)
        }
        return CloudsData
    }
}

// MARK: - Sys
class Sys: NSObject {
    var type: Int?
    var id: Int?
    var country: String?
    var sunrise: Int?
    var sunset: Int?
    
    static func convertedSys(json: JSON) -> Sys {
        let sysValue = Sys()
        if let type = json["type"] as? Int {
            sysValue.type = Int.takeAsIntAlways(type)
        }
        if let idValue = json["id"] as? Int {
            sysValue.id = Int.takeAsIntAlways(idValue)
        }
        if let country = json["country"] as? String {
            sysValue.country = String.takeAsStringAlways(country)
        }
        if let sunrise = json["sunrise"] as? Int {
            sysValue.sunrise = Int.takeAsIntAlways(sunrise)
        }
        if let sunset = json["sunset"] as? Int {
            sysValue.sunset = Int.takeAsIntAlways(sunset)
        }
        return sysValue
    }
}
