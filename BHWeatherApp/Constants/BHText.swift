//
//  BHText.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 19/01/2021.
//

import Foundation

enum BHText: String {
    
    //Mark: Home
    case home_title,
         home_empty
    
    //Mark: Location
    case location_title,
         location_placeholder
    
    //Mark: error msg
    case wrong_data,
         already_exist
    
    var value: String {
        return self.rawValue.localized
    }
}
