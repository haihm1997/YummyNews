//
//  Font.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 22/08/2021.
//

import UIKit

enum Fonts {
    
    static func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func medium(size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Medium", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
}

