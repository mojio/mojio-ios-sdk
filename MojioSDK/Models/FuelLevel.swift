//
//  FuelLevel.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper


// Units are in PercentageUnits
open class FuelLevel: DeviceMeasurement {
    
    open dynamic var RiskSeverity : String? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    open override func mapping(map: Map) {
        super.mapping(map: map)

        RiskSeverity <- map["RiskSeverity"]
    }

}
