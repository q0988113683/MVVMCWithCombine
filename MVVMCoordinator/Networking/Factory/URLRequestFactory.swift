//
//  URLRequestFactory.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/16.
//

import Foundation
struct URLRequestFactory {
    static func createRequest(forEndpoint endpoint: EndPointType,
                              httpMethod: HTTPMethod = .get) -> URLRequest {
        return URLRequest(url: endpoint.url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
    }
}
