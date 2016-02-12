//
//  Odometer.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class Odometer: Mappable {
    
    var RolloverValue : NSNumber?;
    var BaseUnit : NSString?; // ['Meters', 'Miles', 'Kilometers', 'NauticalMiles', 'CentiMeter', 'MilliMeter'],
    var Timestamp : NSString?;
    var BaseValue : NSNumber?;
    var Unit : NSString?;// ['Meters', 'Miles', 'Kilometers', 'NauticalMiles', 'CentiMeter', 'MilliMeter'],
    var Value : NSNumber?;
    
    required init?(_ map: Map) {
        
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
