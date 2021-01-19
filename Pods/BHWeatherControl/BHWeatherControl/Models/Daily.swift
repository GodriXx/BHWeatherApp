//
//  Daily.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

struct Daily: Codable {
    let dailyDt: Int?
    let sunrise: Int?
    let sunset: Int?
    let temp: Temp?
    let feelsLike: FeelsLike?
    let pressure: Int?
    let humidity: Int?
    let wind_speed: Double?
    let weather: [Weather]?
    let uvi: Double?
    
    enum CodingKeys : String, CodingKey {
        case dailyDt = "dt"
        case sunrise, sunset, temp, feelsLike, pressure, humidity, wind_speed, weather, uvi
    }
}
