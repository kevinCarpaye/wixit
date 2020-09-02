//
//  Shop.swift
//  App
//
//  Created by Kévin CARPAYE on 03/11/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import Foundation

class SearchShop: NSObject {
    var name: String?
    var number: String?
    var adress: String?
    var informations: String?
    var image: String?
    var logo: String?
    var price_base: Double?
    var price: Double?
    var date_start: String?
    var date_end: String?
    var sale: Int?
    var link: String?
    var stock: Int?
    var longitude: Float?
    var latitude: Float?
    var distance: Double?
}

class Distance: NSObject {
    var longitude: Float?
    var latitude: Float?
}

struct getShop: Decodable {
    var request: Int
    var result: String
    var shop: [ShopList]
}

struct ShopList: Decodable {
    var name: String
    var number: String
    var adress: String
    var informations: String
    var image: String
    var logo: String
    var latitude: Float
    var longitude: Float
}
