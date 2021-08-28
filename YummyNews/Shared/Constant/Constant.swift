//
//  Constant.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 23/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit

let BASE_URL = "http://api.mediastack.com"

class AccessKeyProvider {
    
    static let shared = AccessKeyProvider()
    
    let accessKeys: [String] = ["90764eede6f1d3ed6d9435e7d37df2ba",
                                "0a9e852c33e48f0d8ce4e102abba4d07",
                                "070c0bb78828223026c1c90a7f0e97fa",
                                "99e732fd0d894aee1b842fda9cf31d91",
                                "4c9cc7ab36bcdc424f15e6a1090d4861"]
    
    func generateAccessKey() -> String {
        return accessKeys.randomItem()
    }
}

enum Constant {
    
    enum Size {
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let screenHeight: CGFloat = UIScreen.main.bounds.height
        static let navigationHeight: CGFloat = SafeArea.topPadding + 56
        static let tabBarHeight: CGFloat = 64
    }
    
    enum NavigationSize {
        static let shadowPathHeight: CGFloat = 2
        static let header: CGFloat = 56
        static let containerHeight: CGFloat = header + SafeArea.topPadding
        static let totalHeight = header + SafeArea.topPadding + shadowPathHeight
    }
    
    enum SafeArea {
        static var topPadding: CGFloat {
            let vsWindow = UIApplication.shared.keyWindow
            if #available(iOS 11.0, *) {
                return vsWindow?.safeAreaInsets.top ?? 0
            } else {
                return UIApplication.shared.statusBarFrame.height
            }
        }
        
        static var bottomPadding: CGFloat {
            let vsWindow = UIApplication.shared.keyWindow
            if #available(iOS 11.0, *) {
                return vsWindow?.safeAreaInsets.bottom ?? 0
            } else {
                return 0
            }
        }
        
        static var bothPadding: CGFloat {
            return topPadding + bottomPadding
        }
    }
    
}
