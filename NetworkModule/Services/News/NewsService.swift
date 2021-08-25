//
//  NewsService.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 22/08/2021.
//

import Foundation
import RxSwift

protocol NewsServiceType {
    func fetchNews(categories: [String], offset: Int) -> Single<NewsResponse>
}

class NewsService {
    
    static let shared: NewsServiceType = NewsService()
    
    let network: Network
    
    private init() {
        let config = NetworkConfiguration(baseURL: URL(string: BASE_URL)!)
        self.network = Network(configuration: config)
    }
    
}

extension NewsService: NewsServiceType {
    
    func fetchNews(categories: [String], offset: Int) -> Single<NewsResponse> {
        let params = NewsAPIParams(categories: categories, offset: offset)
        return network.rx.request(NewsAPIRouter.fetchNews(params: params))
            .validate()
            .responseDecodable(of: NewsResponseModel.self)
            .mapToDomain()
    }
    
}
