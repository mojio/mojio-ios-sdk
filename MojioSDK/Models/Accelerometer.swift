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

public class Accelerometer: Object, Mappable {
    
    public dynamic var X : ProperAcceleration? = nil
    public dynamic var Y : ProperAcceleration? = nil
    public dynamic var Z : ProperAcceleration? = nil
    public dynamic var Magnitude : ProperAcceleration? = nil
    public dynamic var SamplingInterval : TimePeriod? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        X <- map["X"];
        Y <- map["Y"];
        Z <- map["Z"];
        Magnitude <- map["Magnitude"];
        SamplingInterval <- map["SamplingInterval"];
    }

}
