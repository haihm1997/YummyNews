//
//  Pagination.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 22/08/2021.
//

import Foundation

struct PaginationModel: Codable {
    var limit: Int
    var offset: Int
    var count: Int
    var total: Int
}

extension PaginationModel: DomainConvertible {
    func asDomain() -> Pagination {
        return Pagination(limit: limit,
                          offset: offset,
                          count: count,
                          total: total)
    }
}
