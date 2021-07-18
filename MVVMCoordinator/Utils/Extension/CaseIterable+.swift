

import Foundation
extension CaseIterable where Self: Equatable {
    func before() -> Self {
            let all = Self.allCases
        let idx = all.firstIndex(of: self)!
            let previous = all.index(idx, offsetBy: -1)
            return all[previous < all.startIndex ? all.index(idx, offsetBy: -1) : previous]
        }
    
    func next() -> Self {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.startIndex : next]
    }
}
