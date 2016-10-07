//
//  Engine.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class Engine: Mappable {
    
    public dynamic var Name : String? = nil
    public dynamic var Cylinders : String? = nil
    public dynamic var Displacement : Float = 0
    public dynamic var FuelInduction : String? = nil
    public dynamic var FuelQuality : String? = nil
    public dynamic var FuelType : String? = nil
    public dynamic var MaxHp : String? = nil
    public dynamic var MaxHpAt : String? = nil

    public required convenience init?(_ map: Map) {
        self.init();
    }
    
    public required init() {
        
    }

    public func mapping(map: Map) {
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
