//
//  NewsAPIParams.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 22/08/2021.
//

import Foundation

struct NewsAPIParams {
    var access_key: String = Constant.accessKey
    var categories: String?
    var offset: Int
    var search: String? = nil
    
    init(query: String, offset: Int) {
        self.search = query
        self.categories = nil
        self.offset = offset
    }
    
    init(categories: [String], offset: Int) {
        self.search = nil
        self.categories = categories.joined(separator: ",")
        self.offset = offset
    }
    
    func toDict() -> [String: Any] {
        var tempDict: [String: Any] = ["access_key": access_key,
                                       "sources": "cnn,bbc",
                                       "languages": "us",
                                       "countries": "us",
                                       "sort": "published_desc",
                                       "offset": offset,
                                       "limit": 60]
        if let categories = categories {
            tempDict["categories"] = categories
        }
        if let query = search {
            tempDict ["search"] = query
        }
        return tempDict
    }
}
