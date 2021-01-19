//
//  BHText.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 19/01/2021.
//

import Foundation

enum BHText: String {
    
    case home_title,
         home_empty
    
    var value: String {
        return self.rawValue.localized
    }
}
