//
//  Product.swift
//  Challenge
//
//  Created by Fredyson Costa Marques Bentes on 20/07/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation
import ObjectMapper

class Product: Mappable {
    
    var name: String?
    var link: String?
    var imageUrl: String?
    var rating: String?
    var price: String?
    var lastPrice: String?
    var description: String?
    
    required init?(_ map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        name        <- map["name"]
        link        <- map["link"]
        imageUrl    <- map["image"]
        rating      <- map["rating"]
        price       <- map["price"]
        lastPrice   <- map["last_price"]
        description <- map["desc"]
    }
    
}