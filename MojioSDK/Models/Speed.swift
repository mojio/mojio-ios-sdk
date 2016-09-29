//
//  Speed.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class SpeedUnits {
    public static let KilometersPerHour : String = "KilometersPerHour"
    public static let MilesPerHour : String = "MilesPerHour"
}

public class Speed: Mappable {
    
    public dynamic var BaseUnit : String? = nil
    public dynamic var SpeedBandId : Int = 0
    public var SpeedBandDuration : TimePeriod? = nil
    public dynamic var Timestamp  : String? = nil
    public dynamic var BaseValue : Float = 0
    
    // SpeedUnits
    public dynamic var Unit  : String? = nil
    public dynamic var Value : Float = 0
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    public func jsonDict () -> NSDictionary {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Unit != nil {
            dictionary.setObject(self.Unit!, forKey: "Unit")
        }
        
        dictionary.setObject(self.Value, forKey: "Value")
        
        return dictionary
    }
    
    public func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"]
        SpeedBandId <- map["SpeedBandId"]
        SpeedBandDuration <- map["SpeedBandDuration"]
        Timestamp <- map["Timestamp"]
        BaseValue <- map["BaseValue"]
        Unit <- map["Unit"]
        Value <- map["Value"]
    }

}
