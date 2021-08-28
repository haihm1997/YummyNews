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
    
    @IBOutlet weak var premiumView: UIView!
    @IBOutlet weak var premiumHeaderImage: UIImageView!
    @IBOutlet weak var premiumHeaderLabel: UILabel!
    
    var didSelectedMenu: ((_ menuType: YummyMenu) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let isPremium = YummyNewsApplication.shared.isPurchased
        premiumView.isHidden = isPremium
        premiumHeaderImage.image = isPremium ? UIImage(named: "premium_img") : UIImage(named: "ic_basic_plan")
        premiumHeaderImage.layer.borderColor = isPremium ? UIColor.clear.cgColor : UIColor.black.cgColor
        premiumHeaderLabel.text = isPremium ? "Premium Plan" : "Basic Plan"
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
