//
//  NewsListViewModel.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 22/08/2021.
//

import Foundation
import RxSwift
import RxRelay

class NewsListViewModel: BaseViewModel {
        
    let inLoadMore = BehaviorRelay<Int?>(value: nil)
    let inLanguages = BehaviorRelay<[Language]>(value: [])
    
    var outActivity: Observable<Bool>
    var outError: Observable<ProjectError>
    let outNews = BehaviorRelay<[News]>(value: [])
    
    var couldLoadMore: Bool {
        let isPremium = YummyNewsApplication.shared.isPurchased
        return isPremium || inLoadMore.value.map { $0 < 2 } ?? false
    }
    
    init(languages: [Language], categories: [Category]) {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker<String>()
        outError = errorTracker.asDomain()
        outActivity = activityTracker.status(for: LOADING_KEY)
        super.init()
        
        inLanguages.accept(languages)
        
        let service = NewsService.shared
        
        inLoadMore
            .compactMap { $0 }
            .withLatestFrom(inLanguages) { offset, inLangs in
                return service.fetchNews(categories: categories, countries: inLangs, offset: offset)
                    .map { $0.data.shuffled() }
                    .asObservable()
                    .trackError(with: errorTracker)
                    .trackActivity(LOADING_KEY, with: activityTracker)
                    .catchErrorJustReturn([])
            }.flatMap { $0 }
            .map { self.outNews.value + $0 }
            .bind(to: outNews)
            .disposed(by: rx.disposeBag)
    }
    
    func setLanguages(languages: [Language]) {
        inLanguages.accept(languages)
    }
    
}
