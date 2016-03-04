//
//  Odometer.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Odometer: Object, Mappable {
    
    var RolloverValue : Float = 0
    dynamic var BaseUnit : NSString? = nil // ['Meters', 'Miles', 'Kilometers', 'NauticalMiles', 'CentiMeter', 'MilliMeter'],
    dynamic var Timestamp : NSString? = nil
    var BaseValue : Double = 0
    dynamic var Unit : NSString? = nil// ['Meters', 'Miles', 'Kilometers', 'NauticalMiles', 'CentiMeter', 'MilliMeter'],
    var Value : Float = 0
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        RolloverValue <- map["RolloverValue"];
        BaseUnit <- map["BaseUnit"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }
}
