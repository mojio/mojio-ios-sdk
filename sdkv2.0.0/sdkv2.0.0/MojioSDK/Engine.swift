//
//  Engine.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Engine: Object, Mappable {
    
    dynamic var Name : String? = nil
    dynamic var Cylinders : String? = nil
    var Displacement : Float = 0
    dynamic var FuelInduction : String? = nil
    dynamic var FuelQuality : String? = nil
    dynamic var FuelType : String? = nil
    dynamic var MaxHp : String? = nil
    dynamic var MaxHpAt : String? = nil

    required convenience init?(_ map: Map) {
        self.init();
    }
    
    func mapping(map: Map) {
        Name <- map["Name"]
        Cylinders <- map["Cylinders"]
        Displacement <- map["Displacement"]
        FuelInduction <- map["FuelInduction"]
        FuelQuality <- map["FuelQuality"]
        FuelType <- map["FuelType"]
        MaxHp <- map["MaxHp"]
        MaxHpAt <- map["MaxHpAt"]
    }
}
