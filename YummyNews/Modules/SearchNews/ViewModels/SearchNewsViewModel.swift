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
    
    let mockDatas: [News] = [News(), News(), News(), News(), News(), News(), News(), News(), News(), News(), News(), News()]
    
    let outNews = BehaviorRelay<[News]>(value: [])
    
    override init() {
        super.init()
        outNews.accept(mockDatas)
    }
    
}

