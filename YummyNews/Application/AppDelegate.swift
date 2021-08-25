//
//  AppDelegate.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 21/08/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let homeVC = HomeViewController.instantiateFromNib()
        let nav = UINavigationController(rootViewController: homeVC)
        nav.setNavigationBarHidden(true, animated: false)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window        
        return true
    }

}

