//
//  DeviceMeasurement.swift
//  MojioSDK
//
//  Created by Suresh Venkatraman on 10/7/16.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation
import ObjectMapper

// Base Device Measurement
open class DeviceMeasurement: Mappable {

    open dynamic var BaseUnit : String? = nil
    open dynamic var BaseValue : Float = 0
    
    open dynamic var Unit : String? = nil
    open dynamic var Value : Float = 0
    
    open dynamic var Timestamp : String? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {}
    
    open func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"]
        BaseValue <- map["BaseValue"]
        Unit <- map["Unit"]
        Value <- map["Value"]
        Timestamp <- map["Timestamp"]
    }
}
