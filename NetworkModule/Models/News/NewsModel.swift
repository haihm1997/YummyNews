//
//  News.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 22/08/2021.
//

import Foundation

struct NewsModel: Codable {
    var author: String
    var title: String
    var description: String
    var url: String
    var source: String
    var image: String
    var category: String
    var language: String
    var country: String
    var published_at: String
}

extension NewsModel: DomainConvertible {
    func asDomain() -> News {
        return News(author: author, title: title, desc: description,
                    url: url, image: image, category: category, publishAt: published_at)
    }
}
