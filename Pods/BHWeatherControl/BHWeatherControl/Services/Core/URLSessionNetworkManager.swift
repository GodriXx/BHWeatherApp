//
//  URLSessionNetworkManager.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

/**
 
 NetworkManager.
 
 - Author: Bassem Hatira
 
 - Note: NetworkManager is a protocol bridge between AbstractService and URLSessionNetworkManager
 
 */
protocol NetworkManager {
    func perform(request: RouterType,
                 onSuccess: @escaping (Data) -> Void,
                 onError: @escaping (Error) -> Void)
}

/**
 
 URLSessionNetworkManager.
 
 - Author: Bassem Hatira
 
 - Note: URLSessionNetworkManager implement the concrete execution of the HTTP request, used in AbstractService class
 
 */
struct URLSessionNetworkManager: NetworkManager {
    
    static let instance = URLSessionNetworkManager()
    
    private init() {}
    
    func perform(request: RouterType,
                 onSuccess: @escaping (Data) -> Void,
                 onError: @escaping (Error) -> Void) {
        
        // Used for Unit test purpose, bypass this test as Unit test doesn't provide appID
        if NSClassFromString("XCTest") == nil {
            //appID is required for start call
            if BaseConfig.appID == nil {
                onError(ConnexionError.noAppID)
                return
            }
        }
        
        guard let url = URL(string: request.baseURL + request.path) else {
            onError(ConnexionError.errorUrl)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        //add params to HTTP body if exist
        do {
            if let params = request.parameters {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            }
        } catch let error {
            onError(error)
            return
        }
        
        //create task to fetch the contents of a URL
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                //handle error
                onError(error)
                return
            }
            
            guard let data = data else {
                //handle empty data
                onError(ConnexionError.noData)
                return
            }
            //handle success
            onSuccess(data)
        }.resume()
    }
}
