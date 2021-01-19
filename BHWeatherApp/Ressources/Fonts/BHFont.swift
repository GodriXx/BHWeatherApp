//
//  BHFont.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 19/01/2021.
//

import UIKit

enum BHFont {
    
    // MARK: Caption1
    case caption1
    // MARK: Body1
    case body1
    // MARK: Title
    case title
    
    var defaultValue : UIFont {
        switch self {
        case .caption1:
            return self.value(size: 36)
        case .body1:
            return self.value(size: 16)
        case .title:
            return self.value(size: 24)
        }
    }
    
    // MARK: value
    func value(size: CGFloat) -> UIFont {
        switch self {
        case .caption1:
            return UIFont(name:"AppleSDGothicNeo-Thin", size: size)!
        case .title:
            return UIFont(name:"AppleSDGothicNeo-Bold", size: size)!
        case .body1:
            return UIFont(name: "AppleSDGothicNeo-Regular", size: size)!
        }
    }
}

