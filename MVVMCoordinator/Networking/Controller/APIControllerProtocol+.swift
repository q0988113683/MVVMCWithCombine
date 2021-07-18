//
//  APIControllerProtocol+.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/16.
//

import Foundation
import Combine

public typealias APIControllerPublisher<T> = Future<T, Error>
private var subscriptions = Set<AnyCancellable>()

extension APIControllerProtocol {
    func request<T>(specificEndpoit: EndPointType, completionQueue: DispatchQueue = .main)  ->  APIControllerPublisher<T> where T: ResponseType{
        return Future{ promise in
            self.networkController.request(endpoint: specificEndpoit)
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: completionQueue)
                .sink { (error) in
                    promise(.failure(APIError.unowned))
                } receiveValue: { (type) in
                    promise(.success(type))
                }.store(in: &subscriptions)
        }
    }
}
