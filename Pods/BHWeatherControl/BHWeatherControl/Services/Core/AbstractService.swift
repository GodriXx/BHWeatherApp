//
//  AbstractService.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

/**
 
 AbstractService.
 
 - Author: Bassem Hatira
 
 - Note: AbstractService is an abstract and GENERIC class which implements a method of executing an http request
 
 */
class AbstractService<U: RouterType> {
    
    //routerType is the specific request
    var routerType: U?
    
    func execute<T:Codable> (performer: NetworkManager = URLSessionNetworkManager.instance,
                             onSuccess: @escaping (T) -> Void,
                             onError: @escaping (Error?) -> Void) {
        
        guard let routerType = self.routerType else {
            onError(ConnexionError.noRouterType)
            return
        }
        
        //delegate call to the NetworkManager
        performer.perform(request: routerType,
                          onSuccess: { (responseData: Data) in
                            do {
                                //decode data to json format
                                let jsonDecoder = JSONDecoder()
                                let result = try jsonDecoder.decode(T.self, from: responseData)
                                DispatchQueue.main.async {
                                    //handle success
                                    onSuccess(result)
                                }
                            } catch let error {
                                DispatchQueue.main.async {
                                    //handle error in case decoding fail
                                    onError(error)
                                }
                            }
                          },
                          onError: { (error: Error) in
                            DispatchQueue.main.async {
                                //handle error in case request fail
                                onError(error)
                            }
                          })
    }
}

