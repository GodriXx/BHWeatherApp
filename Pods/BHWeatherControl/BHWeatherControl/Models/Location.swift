//
//  Location.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

public struct Location {
    var lat: String
    var lon: String
    
    public init(lat: String, lon: String) {
        self.lat = lat
        self.lon = lon
    }
}
