//
//  SearchNewsViewModel.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 25/08/2021.
//

import Foundation
import RxSwift
import RxRelay

class SearchNewsViewModel: BaseViewModel {
    
    let inLoadMore = BehaviorRelay<Int?>(value: nil)
    let inKeyword = BehaviorRelay<String?>(value: nil)
    
    var outActivity: Observable<Bool>
    var outError: Observable<ProjectError>
    let outNews = BehaviorRelay<[News]>(value: [])
    
    override init() {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker<String>()
        outError = errorTracker.asDomain()
        outActivity = activityTracker.status(for: LOADING_KEY)
        super.init()
        var languages: [Language] = []
        if let rawSavedLanguages = UserDefaults.standard.value(forKey: "isFirstTimeLaunch") as? [String] {
            languages = rawSavedLanguages.compactMap { Language(rawValue: $0) }
        }
        let service = NewsService.shared
        
        inKeyword
            .compactMap { $0 }
            .flatMap {
                return service.fetchNews(query: $0, languages: languages, offset: 0)
                    .map { $0.data.shuffled() }
                    .asObservable()
                    .trackError(with: errorTracker)
                    .trackActivity(LOADING_KEY, with: activityTracker)
                    .catchErrorJustReturn([])
            }.bind(to: outNews)
            .disposed(by: rx.disposeBag)
            
        inLoadMore
            .compactMap { $0 }
            .withLatestFrom(inKeyword) { offset, keyword in
                return service.fetchNews(query: keyword ?? "", languages: languages, offset: offset)
                    .map { $0.data.shuffled() }
                    .asObservable()
                    .trackError(with: errorTracker)
                    .trackActivity(LOADING_KEY, with: activityTracker)
                    .catchErrorJustReturn([])
            }.flatMap { $0 }
            .bind(to: outNews)
            .disposed(by: rx.disposeBag)
    }
    
}

