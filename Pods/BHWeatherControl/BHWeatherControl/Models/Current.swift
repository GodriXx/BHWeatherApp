//
//  Current.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

struct Current: Codable {
    
    let dayDt: Int?
    let sunrise: Int?
    let sunset: Int?
    let temp: Double?
    let feelsLike: Double?
    let pressure: Double?
    let humidity: Int?
    let uvi: Double?
    let visibility: Int?
    let windSpeed: Double?
    let windDeg: Int?
    let weather: [Weather]?
    
    enum CodingKeys : String, CodingKey {
        
        case dayDt = "dt"
        case feelsLike = "feels_like"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case sunrise, sunset, temp, pressure, humidity, uvi, visibility, weather
    }
}
