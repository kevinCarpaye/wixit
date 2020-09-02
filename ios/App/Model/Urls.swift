//
//  Urls.swift
//  App
//
//  Created by Kévin CARPAYE on 25/09/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import Foundation

class Urls {

    private let _BASE_URL : String      = "http://192.168.1.29:4000/api/"
    private let _BASE_URL_IMAGE : String = "http://192.168.1.29:4000/"

    var BASE_URL: String  {
        get {
            return _BASE_URL
        }
    }
    
    var BASE_URL_IMAGE: String {
        get {
            return _BASE_URL_IMAGE
        }
    }

}
 
