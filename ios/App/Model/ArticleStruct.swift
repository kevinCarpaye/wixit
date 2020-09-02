//
//  ArticleStruct.swift
//  App
//
//  Created by Kévin CARPAYE on 16/04/2020.
//  Copyright © 2020 Konex. All rights reserved.
//

import UIKit

class SearchArticle: NSObject {
    var image: String?
    var name: String?
}

struct GetArticle: Decodable {
    var request: Int
    var result: String
    var response: ResponseArticleWithName
}

struct ResponseArticleWithName: Decodable {
    var articles: [Articles]
}
struct Articles: Decodable {
    var name: String
    var image: String
}

struct GetType: Decodable {
    var request: Int
    var result: String
    var response: [Type]
}

struct Type: Decodable {
    var type: String
}
