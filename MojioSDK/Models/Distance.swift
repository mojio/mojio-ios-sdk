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
public class Distance: DeviceMeasurement {
    
    public required convenience init?(_ map: Map) {
        self.init()
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
}
