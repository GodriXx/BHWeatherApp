//
//  BHText.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 19/01/2021.
//

import Foundation

enum BHText: String {
    
    //Mark: General
    case general_temp
    
    //Mark: Home
    case home_title,
         home_empty
    
    //Mark: Location
    case location_title,
         location_placeholder
    
    //Mark: Details
    case details_title,
         details_sunrise,
         details_sunset,
         details_humidity,
         details_windspeed
    
    //Mark: Error messages
    case wrong_data,
         already_exist
    
    var value: String {
        return self.rawValue.localized
    }
}
