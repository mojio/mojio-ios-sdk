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
open class Odometer: DeviceMeasurement {
    
    open dynamic var RolloverValue : Float = 0
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    open func jsonDict () -> NSDictionary {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Unit != nil {
            dictionary.setObject(self.Unit!, forKey: "Unit" as NSCopying)
        }
        
        dictionary.setObject(self.Value, forKey: "Value" as NSCopying)
        
        return dictionary
    }
    
    open override func mapping(map: Map) {
        super.mapping(map: map)

        RolloverValue <- map["RolloverValue"]
    }
}
