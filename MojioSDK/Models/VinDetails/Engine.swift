//
//  Engine.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class Engine: Mappable {
    
    open dynamic var Name : String? = nil
    open dynamic var Cylinders : String? = nil
    open dynamic var Displacement : Float = 0
    open dynamic var FuelInduction : String? = nil
    open dynamic var FuelQuality : String? = nil
    open dynamic var FuelType : String? = nil
    open dynamic var MaxHp : String? = nil
    open dynamic var MaxHpAt : String? = nil

    public required convenience init?(map: Map) {
        self.init();
    }
    
    public required init() {
        
    }

    open func mapping(map: Map) {
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
