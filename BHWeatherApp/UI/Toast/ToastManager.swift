//
//  ToastManager.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import UIKit

private let toastViewTag = -1

class ToastManager {
    
    class func displayToast(type: ToastType,
                            with time: Double = 2.0,
                            and message: String) {
        
        guard let topViewController = UIApplication.topViewController(),
              topViewController.view.subviews.filter({ $0 is ToasterView }).first == nil else { return }
        
        let toasterView = ToasterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toasterView.setup(with: type, and: message)
        toasterView.showWithDuration(time: time)
        // Get specific view which will display the toast
        if let view = topViewController.view.subviews.filter({ $0.tag == toastViewTag }).first {
            toasterView.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: toasterView.frame.size.width, height: toasterView.frame.size.height)
            topViewController.view.addSubview(toasterView)
        } else {
            topViewController.view.addSubview(toasterView)
        }
    }
    
}
