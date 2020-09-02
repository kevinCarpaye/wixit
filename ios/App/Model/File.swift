//
//  File.swift
//  App
//
//  Created by Kévin CARPAYE on 27/10/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import Foundation

struct ScanArticleStruct: Decodable {
    var request: Int
    var result: String
    var reponse: Response
}

struct Response : Decodable {
    var description: String
    var image: String
    var name: String
    var type: String
    
    
}
