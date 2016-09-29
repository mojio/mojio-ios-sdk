//
//  ProperAcceleration.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class AccelerometerUnits  {
    public static let MilliGUnits : String = "MilliGUnits"
    public static let NewtonsPerKilogram : String = "NewtonsPerKilogram"
    public static let XirgoUnit : String = "XirgoUnit"
    public static let MetersPerSecondPerSecond : String = "MetersPerSecondPerSecond"
    public static let CentimetersPerSecondPerSecond : String = "CentimetersPerSecondPerSecond"
    public static let GUnits : String = "GUnits"
}

public class ProperAcceleration: Mappable {

    public dynamic var BaseUnit : String? = nil
    public dynamic var Timestamp : String? = nil
    public dynamic var BaseValue : Float = 0
    
    // AccelerometerUnits
    public dynamic var Unit : String? = nil
    public dynamic var Value : Float = 0
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    public func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"]
        Timestamp <- map["Timestamp"]
        BaseValue <- map["BaseValue"]
        Unit <- map["Unit"]
        Value <- map["Value"]
    }

}
