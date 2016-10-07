//
//  Units.swift
//  MojioSDK
//
//  Created by Suresh Venkatraman on 4/18/16.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation

// Risk Severity
public class RiskSeverity : NSObject {
    public static let Unknown : String = "Unknown"
    public static let Low : String = "Low"
    public static let Medium : String = "Medium"
    public static let High : String = "High"
    public static let None : String = "None"
}

// Distance
public class DistanceUnits : NSObject {
    public static let Meters : String = "Meters"
    public static let Miles : String = "Miles"
    public static let Kilometers : String = "Kilometers"
    public static let NauticalMiles : String = "NauticalMiles"
    public static let CentiMeter : String = "CentiMeter"
    public static let MilliMeter : String = "MilliMeter"
}

// Time
public class TimePeriodUnits : NSObject {
    public static let Ticks : String = "Ticks"
    public static let Milliseconds : String = "Milliseconds"
    public static let Seconds : String = "Seconds"
    public static let Minutes : String = "Minutes"
    public static let Hours : String = "Hours"
    public static let Days : String = "Days"
    public static let Weeks : String = "Weeks"
    public static let Months : String = "Months"
    public static let Years : String = "Years"
}

// Speed
public class SpeedUnits {
    public static let KilometersPerHour : String = "KilometersPerHour"
    public static let MilesPerHour : String = "MilesPerHour"
}

// Acceleration
public class AccelerationUnits : NSObject {
    public static let MetersPerSecondPerSecond : String = "MetersPerSecondPerSecond"
    public static let KilometersPerHourPerSecond : String  = "KilometersPerHourPerSecond"
    public static let MilesPerHourPerSecond : String = "MilesPerHourPerSecond"
}

// Percent
public class PercentageUnits : NSObject {
    public static let Percentage : String = "Percentage"
}

// RPM
public class RPMUnits {
    public static let RevolutionsPerMinute : String = "RevolutionsPerMinute"
}

// Accelerometer
public class AccelerometerUnits: NSObject  {
    public static let MilliGUnits : String = "MilliGUnits"
    public static let NewtonsPerKilogram : String = "NewtonsPerKilogram"
    public static let XirgoUnit : String = "XirgoUnit"
    public static let MetersPerSecondPerSecond : String = "MetersPerSecondPerSecond"
    public static let CentimetersPerSecondPerSecond : String = "CentimetersPerSecondPerSecond"
    public static let GUnits : String = "GUnits"
}

// Battery
public class BatteryVoltageUnits : NSObject {
    public static let MilliVolts : String = "MilliVolts"
    public static let Volts : String = "Volts"
}

// Fuel
public class FuelType : NSObject {
    public static let Query : String = "Query"
    public static let Gasoline : String = "Gasoline"
    public static let Diesel : String = "Diesel"
    public static let Electric : String = "Electric"
}

public class FuelCapacityUnits : NSObject {
    public static let Gallons : String = "Gallons"
    public static let Liters : String = "Liters"
}

public class FuelEfficiencyUnits : NSObject {
    public static let MilesPerGallon : String = "MilesPerGallon"
    public static let KilometerPerLiter : String = "KilometerPerLiter"
    public static let LitersPerHundredKilometers : String = "LitersPerHundredKilometers"
}

public class FuelEfficiencyCalculationMethod : NSObject {
    public static let Query : String = "Query"
    public static let EngineFuelRate : String = "EngineFuelRate"
    public static let MassAirFlow : String = "MassAirFlow"
    public static let Calculated : String = "Calculated"
    public static let None : String = "None"
}

public class FuelVolumeUnits : NSObject {
    public static let Gallon        : String = "Gallon"
    public static let Liter         : String = "Liter"
    public static let Gill          : String = "Gill"
    public static let Pint          : String = "Pint"
    public static let Quart         : String = "Quart"
    public static let Milliliter    : String = "Milliliter"
}
