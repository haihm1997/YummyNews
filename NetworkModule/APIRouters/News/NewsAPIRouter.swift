//
//  NewsAPIRouter.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 22/08/2021.
//

import Foundation
import Alamofire

enum NewsAPIRouter: EndPointConvertible {
    
    case fetchNews(params: NewsAPIParams)
    case search(params: NewsAPIParams)
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .fetchNews:
            return "/v1/news"
        case .search:
            return "/v1/sources"
        }
    }
    
    var encoder: HTTPEncoder {
        switch self {
        case .fetchNews(let params):
            return .urlEncoder(parameters: params.toDict())
        case .search(let params):
            return .urlEncoder(parameters: params.toDict())
        }
    }
    
}
