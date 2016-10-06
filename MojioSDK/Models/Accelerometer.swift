//
//  Accelerometer.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class Accelerometer: Mappable {
    
    public var X : ProperAcceleration? = nil
    public var Y : ProperAcceleration? = nil
    public var Z : ProperAcceleration? = nil
    public var Magnitude : ProperAcceleration? = nil
    public var SamplingInterval : TimePeriod? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }
    
    public func mapping(map: Map) {
        X <- map["X"]
        Y <- map["Y"]
        Z <- map["Z"]
        Magnitude <- map["Magnitude"]
        SamplingInterval <- map["SamplingInterval"]
    }

}
