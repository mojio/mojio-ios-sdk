//
//  Battery.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class BatteryVoltageUnits : NSObject {
    public static let MilliVolts : String = "MilliVolts"
    public static let Volts : String = "Volts"
}

public class Battery : Object, Mappable {
    
    public dynamic var Connected : Bool = false
    
    // RiskSeverity
    public dynamic var RiskSeverity : String? = nil
    public dynamic var LowVoltageDuration : TimePeriod? = nil
    public dynamic var HighVoltageDuration : TimePeriod? = nil
    public dynamic var BaseUnit : String? = nil
    public dynamic var Timestamp : String? = nil
    public dynamic var BaseValue : Float = 0
    
    // BatteryVoltageUnits
    public dynamic var Unit : String? = nil
    public dynamic var Value : Float = 0
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        Connected <- map["Connected"];
        RiskSeverity <- map["RiskSeverity"];
        LowVoltageDuration <- map["LowVoltageDuration"];
        HighVoltageDuration <- map["HighVoltageDuration"];
        BaseUnit <- map["BaseUnit"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }

}
