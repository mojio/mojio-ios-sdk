//
//  Distance.swift
//  Pods
//
//  Created by Ashish Agarwal on 2016-06-28.
//
//

import UIKit
import ObjectMapper
import RealmSwift

public class Distance: Object, Mappable {
    
    public dynamic var BaseUnit : String? = nil
    public dynamic var SpeedBandId : Int = 0
    public dynamic var SpeedBandDuration : TimePeriod? = nil
    public dynamic var Timestamp  : String? = nil
    public dynamic var BaseValue : Float = 0
    
    // SpeedUnits
    public dynamic var Unit  : String? = nil
    public dynamic var Value : Float = 0
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"];
        SpeedBandId <- map["SpeedBandId"];
        SpeedBandDuration <- map["SpeedBandDuration"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }
    
}
