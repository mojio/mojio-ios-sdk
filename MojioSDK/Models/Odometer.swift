//
//  Odometer.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

// Units in DistanceUnits
public class Odometer: DeviceMeasurement {
    
    public dynamic var RolloverValue : Float = 0
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func jsonDict () -> NSDictionary {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Unit != nil {
            dictionary.setObject(self.Unit!, forKey: "Unit")
        }
        
        dictionary.setObject(self.Value, forKey: "Value")
        
        return dictionary
    }
    
    public override func mapping(map: Map) {
        super.mapping(map)

        RolloverValue <- map["RolloverValue"]
    }
}
