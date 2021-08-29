//
//  SplashViewController.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 26/08/2021.
//

import UIKit

class SplashViewController: BaseViewController {
    
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
            loadData {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    let selectLanguageVC = SelectLanguageController()
                    selectLanguageVC.window = self.window
                    self.navigationController?.pushViewController(selectLanguageVC, animated: false)
                    UserDefaults.standard.setValue(false, forKey: "isFirstTimeLaunch")
                }
            }
        }
    }
    
    func loadData(completion: @escaping () -> Void) {
        YummyNewsApplication.shared.appDidFinishLaunching {
            completion()
        }
    }

}
