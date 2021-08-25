//
//  HomeViewModel.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 21/08/2021.
//

import Foundation

enum Category: String, CaseIterable {
    case general
    case business
    case entertainment
    case health
    case science
    case sports
    case technology
    
    var title: String {
        switch self {
        case .general:
            return "For you"
        case .business:
            return "Business"
        case .entertainment:
            return "Entertainment"
        case .health:
            return "Health"
        case .science:
            return "Science"
        case .sports:
            return "Sports"
        case .technology:
            return "Technology"
        }
    }
}

class HomeViewModel: BaseViewModel {
    
}
