//
//  Weather.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

struct Weather: Codable {
    let idWeather: Int?
    let main: String?
    let description: String?
    let icon: String?
    
    enum CodingKeys : String, CodingKey {
        case idWeather = "id"
        case main, description, icon
    }
}
