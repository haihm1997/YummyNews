//
//  ViewController+.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 9/19/20.
//  Copyright © 2020 TonyHoang. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func configure<T>(
        _ value: T,
        using closure: (inout T) throws -> Void
    ) rethrows -> T {
        var value = value
        try closure(&value)
        return value
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
        navigationController?.navigationBar.endEditing(true)
    }

    static func instantiateFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>(_ viewType: T.Type) -> T {
            if UIDevice.current.userInterfaceIdiom == .pad {
                let nibName = String.init(format: "%@_iPad", String(describing: T.self))
                if Bundle(for: T.self).path(forResource: nibName, ofType: "nib") != nil {
                    return T.init(nibName: nibName, bundle: Bundle(for: T.self))
                }
            }
            return T.init(nibName: String(describing: T.self), bundle: Bundle(for: T.self))
        }
        return instantiateFromNib(self)
    }
    
}
