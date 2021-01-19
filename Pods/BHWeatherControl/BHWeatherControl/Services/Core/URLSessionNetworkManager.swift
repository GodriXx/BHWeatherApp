//
//  URLSessionNetworkManager.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

protocol NetworkManager {
    func perform(request: RouterType,
                 onSuccess: @escaping (Data) -> Void,
                 onError: @escaping (Error) -> Void)
}

struct URLSessionNetworkManager: NetworkManager {
    
    static let instance = URLSessionNetworkManager()
    
    private init() {}
    
    func perform(request: RouterType,
                 onSuccess: @escaping (Data) -> Void,
                 onError: @escaping (Error) -> Void) {
        if BaseConfig.appID == nil {
            onError(ConnexionError.noAppID)
            return
        }
        
        guard let url = URL(string: request.baseURL + request.path) else {
            onError(ConnexionError.errorUrl)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        do {
            if let params = request.parameters {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            }
        } catch let error {
            onError(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                onError(error)
                return
            }
            
            guard let data = data else {
                onError(ConnexionError.noData)
                return
            }
            onSuccess(data)
        }.resume()
    }
}
