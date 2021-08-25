//
//  News.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 22/08/2021.
//

import Foundation

struct News {
    var author: String
    var title: String
    var description: String
    var url: String
    var image: String
    var category: String
    var publishAt: String
    
    init() {
        self.author = "Tesssst"
        self.title = "Consumers Energy gives water, food to residents"
        self.description = "Full US Food and Drug Administration approval of the Pfizer/BioNTech Covid-19 vaccine is \"imminent,\" a senior federal official told CNN on Friday -- but said no date has been mentioned."
        self.url = "http://rss.cnn.com/~r/rss/cnn_topstories/~3/YoZ51p6U9Y4/index.html"
        self.image = "https://cdn.cnn.com/cnnnext/dam/assets/210729145647-fda-super-169.jpg"
        self.category = "Category"
        self.publishAt = "2021-08-19T19:55:30"
    }
    
    init(author: String, title: String, desc: String, url: String, image: String, category: String, publishAt: String) {
        self.author = author
        self.title = title
        self.description = desc
        self.url = url
        self.image = image
        self.category = category
        self.publishAt = publishAt
    }
}
