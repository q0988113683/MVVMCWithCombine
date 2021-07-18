

import UIKit
extension UICollectionView {
    
    func register<T>(nibCell cell: T.Type, bundle: Bundle? = .main) where T: NibRegisterable {
        
        register(cell.nib(bundle: bundle), forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
    
    func register<T>(nibSupplementaryView supplementaryView: T.Type, kind: String, bundle: Bundle? = .main) where T: NibRegisterable {
        register(supplementaryView.nib(bundle: bundle), forSupplementaryViewOfKind: kind, withReuseIdentifier: supplementaryView.reuseIdentifier)
    }
    
    func reusableCell<T>(for indexPath: IndexPath) -> T where T: Reusable {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func reusableSupplementaryView<T>(ofKind kind: String, for indexPath: IndexPath) -> T where T: Reusable {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
}

extension UICollectionReusableView: NibRegisterable {
    
}
