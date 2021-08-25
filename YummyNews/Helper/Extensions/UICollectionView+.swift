//
//  UICollectionView+.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 22/08/2021.
//

import UIKit

extension UICollectionView {

    func registerCellNib<T: UICollectionViewCell>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        if UIDevice.current.userInterfaceIdiom == .pad {
            let nibName = String.init(format: "%@_iPad", name)
            if YummyNewsApplication.bundle.path(forResource: nibName, ofType: "nib") != nil {
                let nib = UINib(nibName: nibName, bundle: YummyNewsApplication.bundle)
                self.register(nib, forCellWithReuseIdentifier: name)
                return
            }
        }
        let nib = UINib(nibName: name, bundle: YummyNewsApplication.bundle)
        self.register(nib, forCellWithReuseIdentifier: name)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ aClass: T.Type,idxPath : IndexPath) -> T! {
        let name = String(describing: aClass)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: name, for: idxPath) as? T else  {
            fatalError("\(name) is not registed")
        }
        return cell
    }
    
    func registerHeaderCellNib<T: UICollectionReusableView>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        if UIDevice.current.userInterfaceIdiom == .pad {
            let nibName = String.init(format: "%@_iPad", name)
            if YummyNewsApplication.bundle.path(forResource: nibName, ofType: "nib") != nil {
                let nib = UINib(nibName: nibName, bundle: YummyNewsApplication.bundle)
                self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: name)
                return
            }
        }
        let nib = UINib(nibName: name, bundle: YummyNewsApplication.bundle)
        self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: name)
    }
    
    func dequeueReusableHeaderCell<T: UICollectionReusableView>(_ aClass: T.Type, idxPath : IndexPath) -> T! {
        let name = String(describing: aClass)
        
        guard let cell = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: name, for: idxPath) as? T else  {
            fatalError("\(name) is not registed")
        }
        return cell
    }
    
    func registerFooterCellNib<T: UICollectionReusableView>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        if UIDevice.current.userInterfaceIdiom == .pad {
            let nibName = String.init(format: "%@_iPad", name)
            if YummyNewsApplication.bundle.path(forResource: nibName, ofType: "nib") != nil {
                let nib = UINib(nibName: nibName, bundle: YummyNewsApplication.bundle)
                self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: name)
                return
            }
        }
        let nib = UINib(nibName: name, bundle: YummyNewsApplication.bundle)
        self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: name)
    }
    
    func dequeueReusableFooterCell<T: UICollectionReusableView>(_ aClass: T.Type, idxPath : IndexPath) -> T! {
        let name = String(describing: aClass)
        
        guard let cell = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: name, for: idxPath) as? T else  {
            fatalError("\(name) is not registed")
        }
        return cell
    }
    
    static var leastNonzeroMagnitudeOfGroupedHeaderFooterHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return 0.01
        } else {
            return 1.1
        }
    }
    
    static var spacingView: UICollectionReusableView {
        var frame = CGRect.zero
        frame.size.height = 8.0
        return UICollectionReusableView(frame: frame)
    }
    
    static var nonSpacingView: UICollectionReusableView {
        var frame = CGRect.zero
        frame.size.height = leastNonzeroMagnitudeOfGroupedHeaderFooterHeight
        return UICollectionReusableView(frame: frame)
    }
    
    func reloadItems(inSection section:Int) {
        let num = numberOfItems(inSection: section)
        if num == 0 {
            self.reloadData()
            return
        }
        self.performBatchUpdates({
            // modify here the collection view
            // eg. with: collectionView.insertItems
            // or: collectionView.deleteItems
        }) { (success) in
            self.reloadItems(at: (0..<num).map {
                IndexPath(item: $0, section: section)
            })
        }
    }

}
