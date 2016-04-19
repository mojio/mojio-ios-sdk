//
//  BaseUnits.swift
//  MojioSDK
//
//  Created by Suresh Venkatraman on 4/18/16.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation

public class RiskSeverity : NSObject {
    public static let Unknown : String = "Unknown"
    public static let Low : String = "Low"
    public static let Medium : String = "Medium"
    public static let High : String = "High"
    public static let None : String = "None"
}

public class DistanceUnits : NSObject {
    public static let Meters : String = "Meters"
    public static let Miles : String = "Miles"
    public static let Kilometers : String = "Kilometers"
    public static let NauticalMiles : String = "NauticalMiles"
    public static let CentiMeter : String = "CentiMeter"
    public static let MilliMeter : String = "MilliMeter"
}
