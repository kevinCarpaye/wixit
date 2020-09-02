//
//  GetUserProfilStruct.swift
//  App
//
//  Created by Kévin CARPAYE on 30/09/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import Foundation

struct GetUserProfilStruct : Decodable {
    var request: Int
    var result: String
    var response: ResponseGetUser
}

struct ResponseGetUser : Decodable {
    var userName: String
    var email: String
    var city: String
    var createdAt: String
}


struct ChangePassword : Decodable {
    var request: Int
    var result: String
}
