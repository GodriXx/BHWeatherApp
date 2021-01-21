//
//  Constants.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

struct Constants {
    
    static let baseURL = "https://api.openweathermap.org/data/2.5/"
    static let appLang = String(Locale.preferredLanguages.first?.prefix(2) ?? "en")
}
