//
//  FuelLevel.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class FuelLevel: Mappable {
    
    var BaseUnit : NSString?; //['Percentage']
    var RiskSeverity : NSString?
    var Timestamp : NSString?;
    var BaseValue : NSNumber?;
    var Unit : NSString?;  // ['Percentage']
    var Value : NSNumber?;
    
    required init?(_ map: Map) {
        
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
