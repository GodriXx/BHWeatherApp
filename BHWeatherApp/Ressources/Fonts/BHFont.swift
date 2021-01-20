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
    // MARK: Caption2
    case caption2
    // MARK: Body1
    case body1
    // MARK: Body2
    case body2
    // MARK: Title
    case title
    
    var defaultValue : UIFont {
        switch self {
        case .caption1:
            return self.value(size: 36)
        case .caption2, .title:
            return self.value(size: 24)
        case .body1:
            return self.value(size: 16)
        case .body2:
            return self.value(size: 12)
        }
    }
    
    // MARK: value
    func value(size: CGFloat) -> UIFont {
        switch self {
        case .caption1, .caption2:
            return UIFont(name:"AppleSDGothicNeo-Thin", size: size)!
        case .title:
            return UIFont(name:"AppleSDGothicNeo-Bold", size: size)!
        case .body1, .body2:
            return UIFont(name: "AppleSDGothicNeo-Regular", size: size)!
        }
    }
}

