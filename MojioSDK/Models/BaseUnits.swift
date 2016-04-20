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

public class FuelType : NSObject {
    public static let Query : String = "Query"
    public static let Gasoline : String = "Gasoline"
    public static let Diesel : String = "Diesel"
    public static let Electric : String = "Electric"
}

public class FuelEfficiencyCalculationMethod : NSObject {
    public static let Query : String = "Query"
    public static let EngineFuelRate : String = "EngineFuelRate"
    public static let MassAirFlow : String = "MassAirFlow"
    public static let Calculated : String = "Calculated"
    public static let None : String = "None"
}
