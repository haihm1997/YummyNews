//
//  PremiumViewController.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 26/08/2021.
//

import UIKit
import RxSwift
import RxCocoa

class PremiumViewController: BaseViewController {
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var promotionLabel: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    
    let viewModel = PremiumViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let price = IAPManager.shared.premiumProducts.first?.getPriceFormatted() ?? ""
        promotionLabel.text = "Free 3 days first and you will be charged \(price) per week after"
        purchaseButton.setTitle("\(price) / Week", for: .normal)
        
        bind()
    }
    
    func bind() {
        viewModel.outActivity.bind(to: loadingBinder).disposed(by: rx.disposeBag)
        viewModel.outError.bind(to: ErrorHandler.defaultAlertBinder(from: self)).disposed(by: rx.disposeBag)
        viewModel.outPurchaseSuccess.bind(to: didPurchaseSuccess).disposed(by: rx.disposeBag)
        viewModel.outDidRestoreProduct.bind(to: didRestoreSuccess).disposed(by: rx.disposeBag)
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        viewModel.inPurchasePremium.accept(())
    }
    
    @IBAction func restoreButtonTapped(_ sender: Any) {
        viewModel.inRestoreProduct.accept(())
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PremiumViewController {
    
    var didPurchaseSuccess: Binder<Bool> {
        return Binder(self) { target, _ in
            target.dismiss(animated: true, completion: nil)
        }
    }
    
    var didRestoreSuccess: Binder<Bool> {
        return Binder(self) { target, _ in
            ErrorHandler.showDefaultAlert(message: "Restore completed!", from: target) {
                target.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
