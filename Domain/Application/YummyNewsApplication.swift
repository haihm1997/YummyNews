//
//  YummyNewsApplication.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 21/08/2021.
//

import Foundation

class YummyNewsApplication {
    
    static let shared = YummyNewsApplication()
    
    var isPurchased: Bool = false
    
    static let bundle = Bundle(for: YummyNewsApplication.self)
    
    func appDidFinishLaunching(completion: @escaping () -> Void) {
        IAPManager.shared.startObserving()
        IAPManager.shared.getProducts { [weak self] _ in
            self?.verifyPurchasing()
            completion()
        }
    }
    
    func verifyPurchasing() {
        let userDefault = UserDefaults.standard
        guard let isPurchased = userDefault.value(forKey: "isPurchased") as? Bool else {
            IAPManager.shared.verifyReceipt()
            return
        }
        if isPurchased {
            self.isPurchased = isPurchased
        } else {
            IAPManager.shared.verifyReceipt()
        }
    }
    
}
