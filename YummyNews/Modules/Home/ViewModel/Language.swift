//
//  Language.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 25/08/2021.
//

import Foundation

enum Language: String, CaseIterable {
    case argentina = "ar"
    case australia = "au"
    case brazil = "br"
    case canada = "ca"
    case japan = "jp"
    case indonesia = "id"
    case portugal = "pt"
    case sweden = "se"
    case unitedStates = "us"
    case southKorea = "kr"
    case france = "fr"
    case germany = "de"
    case unitedKingdom = "gb"
    case uae = "ae"
    
    var title: String {
        switch self {
        case .argentina:
            return "Argentina"
        case .australia:
            return "Australia"
        case .brazil:
            return "Brazil"
        case .canada:
            return "Canada"
        case .japan:
            return "Japan"
        case .indonesia:
            return "Indonesia"
        case .portugal:
            return "Portugal"
        case .sweden:
            return "Sweden"
        case .unitedStates:
            return "United States"
        case .southKorea:
            return "South Korea"
        case .france:
            return "France"
        case .germany:
            return "Germany"
        case .unitedKingdom:
            return "United Kingdom"
        case .uae:
            return "UAE"
        }
    }
    
    static func getLanguage(from name: String) -> Language {
        return self.allCases.first(where: { $0.title == name }) ?? .unitedStates
    }
    
}
