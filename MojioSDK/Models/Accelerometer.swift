//
//  Accelerometer.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class Accelerometer: Mappable {
    
    open var X : ProperAcceleration? = nil
    open var Y : ProperAcceleration? = nil
    open var Z : ProperAcceleration? = nil
    open var Magnitude : ProperAcceleration? = nil
    open var SamplingInterval : TimePeriod? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {
        
    }
    
    open func mapping(map: Map) {
        X <- map["X"]
        Y <- map["Y"]
        Z <- map["Z"]
        Magnitude <- map["Magnitude"]
        SamplingInterval <- map["SamplingInterval"]
    }

}
