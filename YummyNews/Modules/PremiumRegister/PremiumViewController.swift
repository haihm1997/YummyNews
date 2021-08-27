//
//  PremiumViewController.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 26/08/2021.
//

import UIKit

class PremiumViewController: UIViewController {
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var promotionLabel: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let price = IAPManager.shared.premiumProducts.first?.getPriceFormatted() ?? ""
        promotionLabel.text = "Free 3 days first and you will be charged \(price) per week after"
        purchaseButton.setTitle("\(price) / Week", for: .normal)
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func restoreButtonTapped(_ sender: Any) {
        
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
