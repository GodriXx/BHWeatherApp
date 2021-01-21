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
    let windSpeed: Double?
    let weather: [Weather]?
    let uvi: Double?
    
    enum CodingKeys : String, CodingKey {
        case dailyDt = "dt"
        case windSpeed = "wind_speed"
        case feelsLike = "feels_like"
        case sunrise, sunset, temp, pressure, humidity, weather, uvi
    }
    
    func getDailyWrapper(timezoneOffset: Int) -> DailyWrapper {
        var dailyWrapper = DailyWrapper(daily: self)
        dailyWrapper.timezoneOffset = timezoneOffset
        return dailyWrapper
    }
}
