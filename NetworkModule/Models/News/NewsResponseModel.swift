//
//  NewsResponse.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 22/08/2021.
//

import Foundation

struct NewsResponseModel: Codable {
    var pagination: PaginationModel
    var data: [NewsModel]
}

extension NewsResponseModel: DomainConvertible {
    func asDomain() -> NewsResponse {
        return NewsResponse(pagination: pagination.asDomain(),
                            data: data.map { $0.asDomain() })
    }
}
