//
//  NetworkController.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/16.
//

import Foundation
import Combine

extension Publisher {
    func extractUnderlyingError() -> Publishers.MapError<Self, Failure> {
        mapError {
            ($0.underlyingError as? Failure) ?? $0
        }
    }
}


public class NetworkController {
    public typealias Value = Decodable
    
    
    private var urlSession: URLSessionProtocol = MockURLSession(factory: ScheduleMockDataController())
    
    public init() {
    }
    
    convenience init(session: URLSessionProtocol) {
        self.init()
        self.urlSession = session
    }
}

extension NetworkController: NetworkControllerProtocol{
    func request<Value>(endpoint: EndPointType) -> ResponseCompletion<Value> {
        
        let request = URLRequestFactory.createRequest(forEndpoint: endpoint)
        
        let publisher =  self.urlSession
            .dataTaskPublisher(for: request)
            .extractUnderlyingError()
            .retry(3)
            .decode(type: Value.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        return publisher
    }
}
