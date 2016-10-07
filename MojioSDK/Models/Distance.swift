//
//  Distance.swift
//  Pods
//
//  Created by Ashish Agarwal on 2016-06-28.
//
//

import UIKit
import ObjectMapper

public class Distance: Mappable {
    
    public dynamic var BaseUnit : String? = nil
    public dynamic var SpeedBandId : Int = 0
    public var SpeedBandDuration : TimePeriod? = nil
    public dynamic var Timestamp  : String? = nil
    public dynamic var BaseValue : Float = 0
    
    // SpeedUnits
    public dynamic var Unit  : String? = nil
    public dynamic var Value : Float = 0
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }
    
    public func jsonDict() -> NSDictionary {
        var dictionary : [String:AnyObject] = [:]
        
        if let baseUnit = self.BaseUnit {
            dictionary["BaseUnit"] = baseUnit
            dictionary["BaseValue"] = self.BaseValue
        }
        
        if let unit = self.Unit {
            dictionary["Unit"] = unit
            dictionary["Value"] = self.Value
        }

        return dictionary
    }
    
    public func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"]
        SpeedBandId <- map["SpeedBandId"]
        SpeedBandDuration <- map["SpeedBandDuration"]
        Timestamp <- map["Timestamp"]
        BaseValue <- map["BaseValue"]
        Unit <- map["Unit"]
        Value <- map["Value"]
    }
    
}
