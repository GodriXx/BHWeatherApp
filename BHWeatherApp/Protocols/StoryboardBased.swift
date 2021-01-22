//
//  StoryboardBased.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 19/01/2021.
//

import UIKit

/**
 
 StoryboardBased: Protocol allow us to instantiate a storyboard from controller's name.
 
 - Author: Bassem Hatira
 
 - Note: This allow us to create a couple of controller and storyboard for each scene to simplify UI creation and avoid huge storyboards; single storyboard, single scene.
 
 */
protocol StoryboardBased: class {
    static var storyboard: UIStoryboard { get }
    static func instanciate() -> Self
}

extension StoryboardBased where Self: UIViewController {
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: String(describing: self), bundle: nil)
    }
    
    static func instanciate() -> Self {
        guard let viewController = self.storyboard.instantiateInitialViewController() as? Self else {
            fatalError("The initial ViewController of storyboard \(storyboard) is not of the expected class \(Self.self)")
        }
        return viewController
    }
    
}
