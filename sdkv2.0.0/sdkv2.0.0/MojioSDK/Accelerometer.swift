//
//  Accelerometer.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Accelerometer: Object, Mappable {
    
    dynamic var X : ProperAcceleration? = nil
    dynamic var Y : ProperAcceleration? = nil
    dynamic var Z : ProperAcceleration? = nil
    dynamic var Magnitude : ProperAcceleration? = nil
    dynamic var SamplingInterval : Duration? = nil
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        X <- map["X"];
        Y <- map["Y"];
        Z <- map["Z"];
        Magnitude <- map["Magnitude"];
        SamplingInterval <- map["SamplingInterval"];
    }

}
