//
//  FuelLevel.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class FuelLevel: Object, Mappable {
    
    dynamic var BaseUnit : NSString? = nil //['Percentage']
    dynamic var RiskSeverity : NSString? = nil
    var Timestamp : NSString? = nil
    var BaseValue : Float = 0
    dynamic var Unit : NSString? = nil  // ['Percentage']
    var Value : Float = 0
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"];
        RiskSeverity <- map["RiskSeverity"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }


}
