//
//  Speed.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class Speed: Mappable {
    
    var BaseUnit : NSString?; // ['KilometersPerHour', 'MilesPerHour'],
    var SpeedBandId : NSInteger?;
    var SpeedBandDuration : Duration?;
    var Timestamp  : NSString?;
    var BaseValue : NSNumber?;
    var Unit  : NSString?;// ['KilometersPerHour', 'MilesPerHour'],
    var Value : NSNumber?;
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"];
        SpeedBandId <- map["SpeedBandId"];
        SpeedBandDuration <- map["SpeedBandDuration"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }

}
