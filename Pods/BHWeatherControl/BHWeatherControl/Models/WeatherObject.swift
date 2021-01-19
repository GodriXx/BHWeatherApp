//
//  WeatherObject.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

public struct WeatherObject: Codable {
    let timezone: String?
    let timezone_offset: Int?
    let current: Current?
    let daily: [Daily]?
}
