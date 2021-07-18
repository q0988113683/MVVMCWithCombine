

import UIKit

protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable where Self: NibProvidableFromClassName {
    static var reuseIdentifier: String {
        return nibName
    }
}

protocol NibRegisterable: Reusable, NibProvidableFromClassName {

}
