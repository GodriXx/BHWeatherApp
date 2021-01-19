//
//  NSObject+BH.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 19/01/2021.
//

import Foundation

extension NSObject {
    
    static var className: String {
        return String(describing: self)
    }
    
}
