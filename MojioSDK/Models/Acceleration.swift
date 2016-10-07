//
//  Acceleration.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class AccelerationUnits : NSObject {
    
    // Meters per second per second
    public static let MetersPerSecondPerSecond : String = "MetersPerSecondPerSecond"
    
    // KiloMeters per hour per second
    public static let KilometersPerHourPerSecond : String  = "KilometersPerHourPerSecond"
    
    // Miles per hour per second
    public static let MilesPerHourPerSecond : String = "MilesPerHourPerSecond"
}

public class Acceleration: DeviceMeasurement {
    public required convenience init?(_ map: Map) {
        self.init()
    }
}
