//
//  Accelerometer.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class Accelerometer: Mappable {
    
    var X : ProperAcceleration?;
    var Y : ProperAcceleration?;
    var Z : ProperAcceleration?;
    var Magnitude : ProperAcceleration?;
    var SamplingInterval : Duration?;
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        X <- map["X"];
        Y <- map["Y"];
        Z <- map["Z"];
        Magnitude <- map["Magnitude"];
        SamplingInterval <- map["SamplingInterval"];
    }

}
