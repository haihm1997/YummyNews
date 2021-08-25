//
//  UITableView+.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 22/08/2021.
//

import UIKit

extension UITableView {
    func registerCellNib<T: UITableViewCell>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        if UIDevice.current.userInterfaceIdiom == .pad {
            let nibName = String.init(format: "%@_iPad", name)
            if YummyNewsApplication.bundle.path(forResource: nibName, ofType: "nib") != nil {
                let nib = UINib(nibName: nibName, bundle: YummyNewsApplication.bundle)
                self.register(nib, forCellReuseIdentifier: name)
                return
            }
        }
        let nib = UINib(nibName: name, bundle: YummyNewsApplication.bundle)
        self.register(nib, forCellReuseIdentifier: name)
    }

    func dequeueReusableCell<T: UITableViewCell>(_ aClass: T.Type, idxPath : IndexPath) -> T! {
        let name = String(describing: aClass)
        guard let cell = dequeueReusableCell(withIdentifier: name, for: idxPath) as? T else {
            fatalError("\(name) is not registed")
        }
        return cell
    }

    func registerHeaderFooterCellNib<T: UITableViewHeaderFooterView>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        if UIDevice.current.userInterfaceIdiom == .pad {
            let nibName = String.init(format: "%@_iPad", name)
            if YummyNewsApplication.bundle.path(forResource: nibName, ofType: "nib") != nil {
                let nib = UINib(nibName: nibName, bundle: YummyNewsApplication.bundle)
                self.register(nib, forHeaderFooterViewReuseIdentifier: name)
                return
            }
        }
        let nib = UINib(nibName: name, bundle: YummyNewsApplication.bundle)
        self.register(nib, forHeaderFooterViewReuseIdentifier: name)
    }

    func dequeueReusableHeaderFooterCell<T: UITableViewHeaderFooterView>(_ aClass: T.Type) -> T! {
        let name = String(describing: aClass)
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: name) as? T else {
            fatalError("\(name) is not registed")
        }
        return cell
    }
    
    @IBInspectable
    var isEmptyRowsHidden: Bool {
        get {
            return tableFooterView != nil
        }
        set {
            if newValue {
                tableFooterView = UIView(frame: .zero)
            } else {
                tableFooterView = nil
            }
        }
    }
    
    static var leastNonzeroMagnitudeOfGroupedHeaderFooterHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return 0.01
        } else {
            return 1.1
        }
    }
    
    static var spacingView: UIView {
        var frame = CGRect.zero
        frame.size.height = 8.0
        return UIView(frame: frame)
    }
    
    static var nonSpacingView: UIView {
        var frame = CGRect.zero
        frame.size.height = leastNonzeroMagnitudeOfGroupedHeaderFooterHeight
        return UIView(frame: frame)
    }
}

