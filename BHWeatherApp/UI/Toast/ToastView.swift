//
//  ToastView.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import UIKit

class ToastView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    func setupContent(with type: ToastType, and message: String) {
        switch type {
        case .APIError:
            self.imageView.image = #imageLiteral(resourceName: "error")
        case .Advice:
            self.imageView.image = #imageLiteral(resourceName: "warning")
        }
        
        self.messageLabel.text = message
    }
}
