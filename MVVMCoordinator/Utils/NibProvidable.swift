

import UIKit

protocol NibProvidable: class {
    static func nib(bundle: Bundle?) -> UINib
}

protocol NibNameProvidable: class {
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
