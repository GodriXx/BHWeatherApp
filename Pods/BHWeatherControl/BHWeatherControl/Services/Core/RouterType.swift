//
//  RouterType.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

protocol RouterType {
    
    // The headers to be used in the request.
    var headers: [String: String]? { get }
    
    // The target's base URL.
    var baseURL: String { get }
    
    // The path to be appended to baseURL to form the full URL.
    var path: String { get }
    
    // The HTTP method used in the request.
    var method: HTTPMethod { get }
    
    // The dictionnary of parameters.
    var parameters: [String: Any]? { get }
}
