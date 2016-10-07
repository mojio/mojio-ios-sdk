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
public class DeviceMeasurement: Mappable {

    public dynamic var BaseUnit : String? = nil
    public dynamic var BaseValue : Float = 0
    
    public dynamic var Unit : String? = nil
    public dynamic var Value : Float = 0
    
    public dynamic var Timestamp : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {}
    
    public func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"]
        BaseValue <- map["BaseValue"]
        Unit <- map["Unit"]
        Value <- map["Value"]
        Timestamp <- map["Timestamp"]
    }
}
