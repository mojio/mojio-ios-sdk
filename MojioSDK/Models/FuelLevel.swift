//
//  FuelLevel.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class FuelLevelUnits : NSObject {
    public static let Percentage : String = "Percentage"
}

public class FuelLevel: Object, Mappable {
    
    public dynamic var BaseUnit : String? = nil
    public dynamic var RiskSeverity : String? = nil
    public dynamic var Timestamp : String? = nil
    public dynamic var BaseValue : Float = 0
    
    // FuelLevelUnits
    public dynamic var Unit : String? = nil
    public dynamic var Value : Float = 0
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"];
        RiskSeverity <- map["RiskSeverity"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }


}
