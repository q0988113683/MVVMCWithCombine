

import UIKit

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable where Self: NibProvidableFromClassName {
    static var reuseIdentifier: String {
        return nibName
    }
}

protocol NibRegisterable: Reusable, NibProvidableFromClassName {

}
