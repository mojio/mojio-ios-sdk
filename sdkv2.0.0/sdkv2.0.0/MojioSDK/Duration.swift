//
//  Duration.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class Duration: Mappable {
    
    var BaseUnit : NSString?; //['Ticks', 'Milliseconds', 'Seconds', 'Minutes', 'Hours', 'Days', 'Weeks']
    var Timestamp : NSString?;
    var BaseValue : NSNumber?;
    var Unit : NSString?;  // ['Ticks', 'Milliseconds', 'Seconds', 'Minutes', 'Hours', 'Days', 'Weeks']
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
