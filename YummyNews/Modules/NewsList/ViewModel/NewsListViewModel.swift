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
    
    let mockDatas: [News] = [News(), News(), News(), News(), News(), News(), News(), News(), News(), News(), News(), News()]
    
    let outNews = BehaviorRelay<[News]>(value: [])
    
    override init() {
        super.init()
        outNews.accept(mockDatas)
    }
    
}
