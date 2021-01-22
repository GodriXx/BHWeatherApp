//
//  UIView+BH.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import UIKit

extension UIView {
    
    func xibSetup(view: UIView) {
        view.frame = bounds
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[childView]-0-|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[childView]-0-|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
    }
    
    class func viewFromNib<U>(nibName: U.Type) -> U where U: UIView {
        return UINib(nibName: String(describing: U.self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! U
    }
}
