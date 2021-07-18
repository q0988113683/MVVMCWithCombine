

import Foundation

extension Dictionary where Value == [(Date, Bool)] {
    mutating func append(from: [Key: Value]) {
        _ = from.map { (key , value) -> Void in
            self[key]?.append(contentsOf: value)
        }
    }
}
