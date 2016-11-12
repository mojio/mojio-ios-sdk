//
//  Battery.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

// Units in BatteryVoltageUnits
public class Battery : DeviceMeasurement {
    
    public dynamic var Connected : Bool = false
    
    // RiskSeverity
    public dynamic var RiskSeverity : String? = nil
    public var LowVoltageDuration : TimePeriod? = nil
    public var HighVoltageDuration : TimePeriod? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public override func mapping(map: Map) {
        super.mapping(map)

        Connected <- map["Connected"]
        RiskSeverity <- map["RiskSeverity"]
        LowVoltageDuration <- map["LowVoltageDuration"]
        HighVoltageDuration <- map["HighVoltageDuration"]
    }
}
