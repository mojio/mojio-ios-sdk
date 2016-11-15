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
open class Speed: DeviceMeasurement {
    
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
}
