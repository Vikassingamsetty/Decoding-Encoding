//
//  Resources.swift
//  Decoding & Encoding
//
//  Created by Srans022019 on 05/05/20.
//  Copyright © 2020 vikas. All rights reserved.
//

import Foundation

struct Response: Codable {
    
    var shops:[Shop]?
    var banners:[Banner]?
    
}

struct Shop: Codable {
    let name:String?
    let phone : String?
    let device_type:String?
    let avatar:String?
}

struct Banner: Codable {
    let product_id : Int?
}
