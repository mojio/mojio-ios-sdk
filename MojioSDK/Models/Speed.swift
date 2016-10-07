//
//  Speed.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

// Units in SpeedUnits
public class Speed: DeviceMeasurement {
    
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
}
