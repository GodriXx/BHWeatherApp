//
//  UISearchBar+BH.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 20/01/2021.
//

import UIKit

extension UISearchBar {
    
    // Get UISearchBar's UITextField
    func getTextField() -> UITextField? { return value(forKey: "searchField") as? UITextField }
    
    // Set UISearchBar's UITextField background color
    func setTextField(color: UIColor) {
        guard let textField = getTextField() else { return }
        switch searchBarStyle {
        case .minimal:
            textField.layer.backgroundColor = color.cgColor
            textField.layer.cornerRadius = 6
        case .prominent, .default: textField.backgroundColor = color
        @unknown default: break
        }
    }
    
    // Set UISearchBar's UITextField text font
    func setTextFieldFont() {
        if let textField = getTextField() {
            textField.font = BHFont.title1.defaultValue
        }
    }
}
