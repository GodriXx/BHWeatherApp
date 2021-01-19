//
//  Current.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

struct Current: Codable {
    let temp: Double?
    let weather: [Weather]?
}
