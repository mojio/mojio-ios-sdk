//
//  Distance.swift
//  Pods
//
//  Created by Ashish Agarwal on 2016-06-28.
//
//

import UIKit
import ObjectMapper

// Units in DistanceUnits
open class Distance: DeviceMeasurement {
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    open func jsonDict() -> NSDictionary {
        var dictionary : [String:AnyObject] = [:]
        
        if let baseUnit = self.BaseUnit {
            dictionary["BaseUnit"] = baseUnit as AnyObject?
            dictionary["BaseValue"] = self.BaseValue as AnyObject?
        }
        
        if let unit = self.Unit {
            dictionary["Unit"] = unit as AnyObject?
            dictionary["Value"] = self.Value as AnyObject?
        }

        return dictionary as NSDictionary
    }
}
