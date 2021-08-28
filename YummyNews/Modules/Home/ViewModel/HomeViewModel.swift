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
    
    var selectedLanguages: [Language] = [.unitedStates]
    
    override init() {
        super.init()
        if let rawSavedLanguages = UserDefaults.standard.value(forKey: "isFirstTimeLaunch") as? [String] {
            self.selectedLanguages = rawSavedLanguages.compactMap { Language(rawValue: $0) }
        }
    }
    
    func setSelectedLanguages(selectedLanguages: [Language]) {
        self.selectedLanguages = selectedLanguages
    }
    
}
