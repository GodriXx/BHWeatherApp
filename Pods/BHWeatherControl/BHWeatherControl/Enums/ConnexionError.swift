//
//  ConnexionError.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

//basic errors
public enum ConnexionError: Swift.Error {
    case errorUrl
    case noData
    case noRouterType
    case noAppID
    case internalError
}
