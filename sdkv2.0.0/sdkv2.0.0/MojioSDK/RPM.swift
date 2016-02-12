//
//  RPM.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class RPM: Mappable {
    
    var BaseUnit : NSString?; //['RevolutionsPerMinute'],
    var Timestamp : NSString?;
    var BaseValue : NSNumber?;
    var Unit : NSString?;  //['RevolutionsPerMinute'],
    var Value : NSNumber?;
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }

}
