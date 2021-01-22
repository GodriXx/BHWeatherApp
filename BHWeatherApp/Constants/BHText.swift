//
//  BHText.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 19/01/2021.
//

import Foundation

// enum contains all app strings enumarated, this allow us to get rid of strings in the code
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
         already_exist,
         no_connection
    
    var value: String {
        return self.rawValue.localized
    }
}
