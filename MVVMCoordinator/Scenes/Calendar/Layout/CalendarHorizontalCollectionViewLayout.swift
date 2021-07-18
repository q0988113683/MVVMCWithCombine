//
//  CalendarHorizontalCollectionViewLayout.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/15.
//

import UIKit
public class CalendarHorizontalCollectionViewLayout: UICollectionViewLayout {
    fileprivate var headerHeight: CGFloat = 68
    fileprivate var headerWidth: CGFloat = 0
    fileprivate var cellHeight: CGFloat = 26
    fileprivate var cellWidth: CGFloat = 0
    
    fileprivate var cellSpacing: CGFloat = 5
    
    fileprivate var contentHeight: CGFloat = 0
    fileprivate var contentWidth: CGFloat = 0{
        didSet{
            guard let collectionView = collectionView else {
                return
            }
            let width = ((contentWidth - (cellSpacing)) / CGFloat(collectionView.numberOfSections)) - cellSpacing
            headerWidth = width
            cellWidth = width
        }
    }
    
    fileprivate lazy var headerCache: [IndexPath : UICollectionViewLayoutAttributes] = [:]
    fileprivate lazy var cellCache: [IndexPath : UICollectionViewLayoutAttributes] = [:]
  
    
    override public func prepare() {
        super.prepare()
        
        setDefault()
        makeAttributes()
    }
    
    func makeAttributes(){
        guard let collectionView = collectionView, collectionView.numberOfSections > 0 else {
            return
        }
        
        for section in 0...(collectionView.numberOfSections - 1) {
            if  collectionView.numberOfItems(inSection: section) > 0 {
                var cellMaxHeight: CGFloat = headerHeight
                for item in 0...(collectionView.numberOfItems(inSection: section) - 1){
                    //cell
                    let cellIndexPath = IndexPath(item: item, section: section)
                    let shiftX = cellSpacing + CGFloat(section) * (cellWidth + cellSpacing)
                    let shiftY = (CGFloat(item) * cellHeight) + headerHeight
                    let cellAttr = UICollectionViewLayoutAttributes(forCellWith: cellIndexPath)
                    cellAttr.frame = CGRect(x: shiftX, y: shiftY, width: headerWidth, height: headerHeight)
                    cellCache[cellIndexPath] = cellAttr
                    cellMaxHeight = cellMaxHeight + headerHeight
                }
                contentHeight = max(contentHeight, cellMaxHeight)
            }
            
            //Header
            let headerIndexPath = IndexPath(item: 0, section: section)
            let shiftX: CGFloat = cellSpacing + CGFloat(section) * (headerWidth + cellSpacing)
            let shiftY: CGFloat = 0
            
            let cellAttr = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind:  UICollectionView.elementKindSectionHeader, with: headerIndexPath)
            cellAttr.frame = CGRect(x: shiftX, y: shiftY, width: headerWidth, height: headerHeight)
            headerCache[headerIndexPath] = cellAttr
        }
        
        
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        //header
        for headerAttributes in self.headerCache.values {
            layoutAttributes.append(headerAttributes)
        }
        
        //cell
        for cellAttributes in cellCache.values{
            layoutAttributes.append(cellAttributes)
        }
    
        return layoutAttributes
    }
    
    public override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if elementKind == UICollectionView.elementKindSectionHeader{
            return headerCache[indexPath]
        }
        return nil
    }
    
    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellCache[indexPath]
    }
    
    override public var collectionViewContentSize : CGSize {
        return CGSize(width: self.contentWidth, height: self.contentHeight)
    }
    
    fileprivate func setDefault(){
        guard let collectionView = collectionView else {
            return
        }
        cellCache = [:]
        contentWidth = collectionView.bounds.width
        
    }
}
