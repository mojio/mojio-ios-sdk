//
//  ProperAcceleration.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class ProperAcceleration: Object, Mappable {

    dynamic var BaseUnit : NSString? = nil //['MilliGUnits', 'NewtonsPerKilogram', 'XirgoUnit', 'MetersPerSecondPerSecond', 'CentimetersPerSecondPerSecond', 'GUnits']
    dynamic var Timestamp : NSString? = nil
    var BaseValue : Float = 0
    dynamic var Unit : NSString? = nil  // ['MilliGUnits', 'NewtonsPerKilogram', 'XirgoUnit', 'MetersPerSecondPerSecond', 'CentimetersPerSecondPerSecond', 'GUnits']
    var Value : Float = 0
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }

}
