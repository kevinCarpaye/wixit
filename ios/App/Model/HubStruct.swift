//
//  HubStruct.swift
//  App
//
//  Created by Kevin on 14/12/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import Foundation

struct HubStruct: Decodable {
    var type: Int?
    var name: String?
    var message: String?
    var to: String?
    var favorite: Bool?
    var time: String?
}
