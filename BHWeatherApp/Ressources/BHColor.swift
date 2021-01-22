//
//  BHColor.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import UIKit

// enum contains all colors used in app
enum BHColor {
    case lightGray
    
    var value: UIColor {
        switch self {
        case .lightGray:
            return UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        }
    }
    
}
