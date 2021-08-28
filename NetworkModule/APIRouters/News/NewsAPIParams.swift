//
//  NewsAPIParams.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 22/08/2021.
//

import Foundation

struct NewsAPIParams {
    var categories: String?
    var offset: Int
    var search: String? = nil
    var countries: String
    
    init(query: String, languages: [Language], offset: Int) {
        self.search = query
        self.categories = nil
        self.offset = offset
        if languages.isEmpty {
            self.countries = "us"
        } else {
            self.countries = languages.map { $0.rawValue }.joined(separator: ",")
        }
    }
    
    init(categories: [Category], languages: [Language], offset: Int) {
        self.search = nil
        self.categories = categories.isEmpty ? nil : categories.map { $0.rawValue }.joined(separator: ",")
        self.offset = offset
        if languages.isEmpty {
            self.countries = "us"
        } else {
            self.countries = languages.map { $0.rawValue }.joined(separator: ",")
        }
    }
    
    func toDict() -> [String: Any] {
        var tempDict: [String: Any] = ["access_key": AccessKeyProvider.shared.generateAccessKey(),
                                       "sources": "-cnn",
                                       "languages": "en",
                                       "countries": countries,
                                       "sort": "published_desc",
                                       "offset": offset,
                                       "limit": 60]
//        if let categories = categories {
//            tempDict["categories"] = categories
//        }
        if let query = search {
            tempDict ["search"] = query
        }
        return tempDict
    }
}
