//
//  Odometer.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public typealias OdometerUnits = DistanceUnits

public class Odometer: Object, Mappable {
    
    public dynamic var RolloverValue : Float = 0
    public dynamic var BaseUnit : NSString? = nil
    public dynamic var Timestamp : NSString? = nil
    public dynamic var BaseValue : Double = 0
    public dynamic var Unit : NSString? = nil
    public dynamic var Value : Float = 0
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        RolloverValue <- map["RolloverValue"];
        BaseUnit <- map["BaseUnit"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }
}
