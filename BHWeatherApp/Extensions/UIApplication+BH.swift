//
//  UIApplication+BH.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import UIKit

extension UIApplication {

    // Get displayed top viewController
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)

        } else if let base = base,
                  let presented = base.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
