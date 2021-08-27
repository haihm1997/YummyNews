//
//  PremiumViewModel.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 26/08/2021.
//

import Foundation
import RxSwift
import RxCocoa

class PremiumViewModel: BaseViewModel {
        
    let isPremium = BehaviorRelay<Bool>(value: false)
    let inPurchasePremium = PublishRelay<Void>()
    let inRestoreProduct = PublishRelay<Void>()
    
    let outError: Observable<ProjectError>
    let outActivity: Observable<Bool>
    let outPurchaseSuccess = PublishRelay<Bool>()
    let outDidRestoreProduct = PublishRelay<Bool>()
    
    override init() {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker<String>()
        let profileUseCase = PremiumUseCase()
        
        outError = errorTracker.asDomain()
        outActivity = activityTracker.status(for: LOADING_KEY)
        super.init()
        
        inPurchasePremium
            .flatMap { profileUseCase.executePurchase()
                .asObservable()
                .trackActivity(LOADING_KEY, with: activityTracker)
                .trackError(with: errorTracker)
            }
            .bind(to: outPurchaseSuccess)
            .disposed(by: rx.disposeBag)
        
        inRestoreProduct
            .flatMap { profileUseCase.restorePremium()
                .asObservable()
                .trackError(with: errorTracker)
            }
            .bind(to: outDidRestoreProduct)
            .disposed(by: rx.disposeBag)
    }
    
}


class PremiumUseCase {
    
    func executePurchase() -> Single<Bool> {
        return Single.create { single in
            guard let premiumProduct = IAPManager.shared.premiumProducts.first else {
                single(.error(ProjectError.premiumRegisterFailed))
                return Disposables.create()
            }
            IAPManager.shared.buy(product: premiumProduct) { result in
                switch result {
                case .success(let success):
                    let userDefault = UserDefaults.standard
                    userDefault.setValue(success, forKey: "isPurchased")
                    YummyNewsApplication.shared.isPurchased = true
                    single(.success(true))
                case .failure:
                    single(.error(ProjectError.premiumRegisterFailed))
                }
            }
            return Disposables.create()
        }
    }
    
    func restorePremium() -> Single<Bool> {
        return Single.create { single in
            IAPManager.shared.restorePurchases { result in
                switch result {
                case .success(let status):
                    single(.success(status))
                    YummyNewsApplication.shared.isPurchased = status
                case .failure:
                    single(.success(false))
                    YummyNewsApplication.shared.isPurchased = false
                }
            }
            return Disposables.create()
        }
    }
    
    func fetchProducts() -> Single<Void> {
        return Single.create { single in
            IAPManager.shared.getProducts { result in
                switch result {
                case .success:
                    single(.success(()))
                case .failure(let error):
                    single(.error(error))
                }
            }
            return Disposables.create()
        }
    }
    
}
