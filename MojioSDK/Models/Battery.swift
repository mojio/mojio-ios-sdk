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
open class Battery : DeviceMeasurement {
    
    open dynamic var Connected : Bool = false
    
    // RiskSeverity
    open dynamic var RiskSeverity : String? = nil
    open var LowVoltageDuration : TimePeriod? = nil
    open var HighVoltageDuration : TimePeriod? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    open override func mapping(map: Map) {
        super.mapping(map: map)

        Connected <- map["Connected"]
        RiskSeverity <- map["RiskSeverity"]
        LowVoltageDuration <- map["LowVoltageDuration"]
        HighVoltageDuration <- map["HighVoltageDuration"]
    }
}
