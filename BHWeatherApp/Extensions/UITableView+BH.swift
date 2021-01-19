//
//  UITableView+BH.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 19/01/2021.
//

import UIKit

extension UITableView {
    
    func registerCell(name: String) {
        register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
}
