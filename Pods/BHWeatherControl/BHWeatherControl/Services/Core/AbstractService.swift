//
//  AbstractService.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 18/01/2021.
//

import Foundation

class AbstractService<U: RouterType> {
    
    var routerType: U?
    
    func execute<T:Codable> (performer: NetworkManager = URLSessionNetworkManager.instance,
                             onSuccess: @escaping (T) -> Void,
                             onError: @escaping (Error?) -> Void) {
        guard let routerType = self.routerType else {
            onError(ConnexionError.noRouterType)
            return
        }
        performer.perform(request: routerType,
                          onSuccess: { (responseData: Data) in
                            do {
                                let jsonDecoder = JSONDecoder()
                                let result = try jsonDecoder.decode(T.self, from: responseData)
                                DispatchQueue.main.async {
                                    onSuccess(result)
                                }
                            } catch let error {
                                DispatchQueue.main.async {
                                    onError(error)
                                }
                            }
                          },
                          onError: { (error: Error) in
                            DispatchQueue.main.async {
                                onError(error)
                            }
                          })
    }
}

