//
//  WeatherObject.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

struct WeatherObject: Codable {
    let lon: Double?
    let lat: Double?
    let timezone: String?
    let timezoneOffset: Int?
    let current: Current?
    let daily: [Daily]?
    
    enum CodingKeys : String, CodingKey {
        case timezoneOffset = "timezone_offset"
        case timezone, current, daily, lon, lat
    }
    
    func getWeatherWrapper() -> WeatherWrapper {
        return WeatherWrapper(weatherObject: self)
    }
}
