//
//  Error+.swift
//  MVVMCoordinator
//
//  Created by Polo on 2022/10/23.
//

import Foundation

extension Error {
    var underlyingError: Error? {
        let nsError = self as NSError
        if nsError.domain == NSURLErrorDomain && nsError.code == -1009 {
            // "The Internet connection appears to be offline."
            return self
        }
        return nsError.userInfo[NSUnderlyingErrorKey] as? Error
    }
}
