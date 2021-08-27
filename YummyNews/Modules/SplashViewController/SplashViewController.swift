//
//  SplashViewController.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 26/08/2021.
//

import UIKit

class SplashViewController: UIViewController {
    
    var window: UIWindow!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstTime = UserDefaults.standard.value(forKey: "isFirstTimeLaunch") as? Bool,
           !firstTime {
            loadData { [weak self] in
                DispatchQueue.main.async {
                    let homeVC = HomeViewController.instantiateFromNib()
                    let nav = UINavigationController(rootViewController: homeVC)
                    nav.setNavigationBarHidden(true, animated: false)
                    self?.window.rootViewController = nav
                    self?.window.makeKeyAndVisible()
                }
            }
        } else {
            let selectLanguageVC = SelectLanguageController()
            selectLanguageVC.window = window
            navigationController?.pushViewController(selectLanguageVC, animated: false)
            UserDefaults.standard.setValue(false, forKey: "isFirstTimeLaunch")
        }
    }
    
    func loadData(completion: @escaping () -> Void) {
        YummyNewsApplication.shared.appDidFinishLaunching {
            completion()
        }
    }

}
