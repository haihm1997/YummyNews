//
//  BookmarksViewModel.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 26/08/2021.
//

import Foundation
import RxSwift
import RxRelay

class BookmarksViewModel: BaseViewModel {
        
    let outNews = BehaviorRelay<[News]>(value: [])
    
    override init() {
        super.init()
    }
    
}

