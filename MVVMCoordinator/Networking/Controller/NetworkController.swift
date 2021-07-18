//
//  NetworkController.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/16.
//

import Foundation
import Combine

public class NetworkController: NetworkControllerProtocol {
    func request(endpoint: EndPointType) -> Future<Data, Error> {
        
        let request = URLRequestFactory.createRequest(forEndpoint: endpoint)
        
        return Future<Data, Error> { [weak self] promise in

            guard let strongSelf = self else{
                return
            }
            let task = strongSelf.urlSession.dataTask(with: request,
                                                      completionHandler: {(data, response, error) in
                                                        if let error = error {
                                                            promise(.failure(error))
                                                            return
                                                        }
                                                        promise(.success(data!))
                                                      })
            task.resume()
        }
        
    }
    
    private var urlSession: URLSessionProtocol = MockURLSession(factory: ScheduleMockDataController())
    
    public init() {
    }
    
    convenience init(session: URLSessionProtocol) {
        self.init()
        self.urlSession = session
    }
}
