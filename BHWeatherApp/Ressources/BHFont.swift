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
    // MARK: Caption3
    case caption3
    // MARK: Body1
    case body1
    // MARK: Body2
    case body2
    // MARK: Body3
    case body3
    // MARK: Body4
    case body4
    // MARK: Title1
    case title1
    // MARK: Title2
    case title2
    
    var defaultValue : UIFont {
        switch self {
        case .caption1:
            return self.value(size: 36)
        case .caption2, .title1, .body4:
            return self.value(size: 24)
        case .caption3:
            return self.value(size: 10)
        case .body1:
            return self.value(size: 16)
        case .body2:
            return self.value(size: 12)
        case .body3:
            return self.value(size: 20)
        case .title2:
            return self.value(size: 64)
        }
    }
    
    // MARK: value
    func value(size: CGFloat) -> UIFont {
        switch self {
        case .title2:
            return UIFont(name:"AppleSDGothicNeo-UltraLight", size: size)!
        case .caption1, .caption2:
            return UIFont(name:"AppleSDGothicNeo-Thin", size: size)!
        case .title1:
            return UIFont(name:"AppleSDGothicNeo-Bold", size: size)!
        case .body1, .body2, .body3, .body4, .caption3:
            return UIFont(name: "AppleSDGothicNeo-Regular", size: size)!
        }
    }
}

