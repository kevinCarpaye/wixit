//
//  UserStruct.swift
//  App
//
//  Created by Kévin CARPAYE on 14/11/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit

struct UserLoginStruct : Decodable {
    var result: String
    var request: Int
    var response: [ResponseUser]
}

struct ResponseUser : Decodable {
    var name: String
    var email: String
}

struct UserRegisterStruct : Decodable {
    var request: Int
    var result: String
}
