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
public class FuelLevel: DeviceMeasurement {
    
    public dynamic var RiskSeverity : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public override func mapping(map: Map) {
        super.mapping(map)

        RiskSeverity <- map["RiskSeverity"]
    }

}
