

import UIKit

protocol NibProvidable: AnyObject {
    static func nib(bundle: Bundle?) -> UINib
}

protocol NibNameProvidable: AnyObject {
    static var nibName: String { get }
}

protocol NibProvidableFromClassName: NibProvidable, NibNameProvidable {
    
}

extension NibProvidableFromClassName {
    
    static var nibName: String {
        return String(describing: self)
    }
    
    static func nib(bundle: Bundle? = .main) -> UINib {
        return UINib(nibName: nibName, bundle: bundle)
    }

}
