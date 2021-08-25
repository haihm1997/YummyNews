//
//  YummyMenuViewController.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 24/08/2021.
//

import UIKit

enum YummyMenu {
    case premium
    case favorite
    case bookmarked
    case termOfUse(url: String)
    case privaryPolicy(url: String)
}

class YummyMenuViewController: BaseViewController {
    
    var didSelectedMenu: ((_ menuType: YummyMenu) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func premiumButtonTapped(_ sender: Any) {
        self.dismiss(animated: true) { [weak self] in
            self?.didSelectedMenu?(.premium)
        }
        
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        self.dismiss(animated: true) { [weak self] in
            self?.didSelectedMenu?(.favorite)
        }
    }
    
    @IBAction func bookmarkTapped(_ sender: Any) {
        self.dismiss(animated: true) { [weak self] in
            self?.didSelectedMenu?(.bookmarked)
        }
       
    }
    
    @IBAction func termOfUseButtonTapped(_ sender: Any) {
        self.dismiss(animated: true) { [weak self] in
            self?.didSelectedMenu?(.termOfUse(url: "https://tngstudio.blogspot.com/2021/07/terms-of-vip-service.html"))
        }
    }
    
    @IBAction func privacyButtonTapped(_ sender: Any) {
        self.dismiss(animated: true) { [weak self] in
            self?.didSelectedMenu?(.privaryPolicy(url: "https://tngstudio.blogspot.com/2021/07/policy.html"))
        }
    }
    
}
