//
//  GetArticleWithCBStruct.swift
//  App
//
//  Created by Kévin CARPAYE on 17/10/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit

struct GetArticleWithCBStuct: Decodable {
    var request: Int
    var result: String
    var response: Responses
}

struct Responses : Decodable {
    var article: [Article]
    var shops: [Shops]
}

struct Article: Decodable {
    var name: String
    var barcode: String
    var type: String
    var image: String
    var description: String
    var createdAt: String
}

struct Shops: Decodable {
    var name: String
    var number: String
    var adress: String
    var informations: String
    var image: String
    var logo: String
    var price_base: Double
    var price: Double
    var link: String
    var stock: Int
    var date_start: String
    var date_end: String
    var latitude: Float
    var longitude: Float
}


struct AddArticleStruct: Decodable {
    var request: Int
    var result: String
}
