//
//  Units.swift
//  MojioSDK
//
//  Created by Suresh Venkatraman on 4/18/16.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation

// Risk Severity
open class RiskSeverity : NSObject {
    open static let Unknown : String = "Unknown"
    open static let Low : String = "Low"
    open static let Medium : String = "Medium"
    open static let High : String = "High"
    open static let None : String = "None"
}

// Distance
open class DistanceUnits : NSObject {
    open static let Meters : String = "Meters"
    open static let Miles : String = "Miles"
    open static let Kilometers : String = "Kilometers"
    open static let NauticalMiles : String = "NauticalMiles"
    open static let CentiMeter : String = "CentiMeter"
    open static let MilliMeter : String = "MilliMeter"
}

// Time
open class TimePeriodUnits : NSObject {
    open static let Ticks : String = "Ticks"
    open static let Milliseconds : String = "Milliseconds"
    open static let Seconds : String = "Seconds"
    open static let Minutes : String = "Minutes"
    open static let Hours : String = "Hours"
    open static let Days : String = "Days"
    open static let Weeks : String = "Weeks"
    open static let Months : String = "Months"
    open static let Years : String = "Years"
}

// Speed
open class SpeedUnits {
    open static let KilometersPerHour : String = "KilometersPerHour"
    open static let MilesPerHour : String = "MilesPerHour"
}

// Acceleration
open class AccelerationUnits : NSObject {
    open static let MetersPerSecondPerSecond : String = "MetersPerSecondPerSecond"
    open static let KilometersPerHourPerSecond : String  = "KilometersPerHourPerSecond"
    open static let MilesPerHourPerSecond : String = "MilesPerHourPerSecond"
}

// Percent
open class PercentageUnits : NSObject {
    open static let Percentage : String = "Percentage"
}

// RPM
open class RPMUnits {
    open static let RevolutionsPerMinute : String = "RevolutionsPerMinute"
}

// Accelerometer
open class AccelerometerUnits: NSObject  {
    open static let MilliGUnits : String = "MilliGUnits"
    open static let NewtonsPerKilogram : String = "NewtonsPerKilogram"
    open static let XirgoUnit : String = "XirgoUnit"
    open static let MetersPerSecondPerSecond : String = "MetersPerSecondPerSecond"
    open static let CentimetersPerSecondPerSecond : String = "CentimetersPerSecondPerSecond"
    open static let GUnits : String = "GUnits"
}

// Battery
open class BatteryVoltageUnits : NSObject {
    open static let MilliVolts : String = "MilliVolts"
    open static let Volts : String = "Volts"
}

// Fuel
open class FuelType : NSObject {
    open static let Query : String = "Query"
    open static let Gasoline : String = "Gasoline"
    open static let Diesel : String = "Diesel"
    open static let Electric : String = "Electric"
}

open class FuelCapacityUnits : NSObject {
    open static let Gallons : String = "Gallons"
    open static let Liters : String = "Liters"
}

open class FuelEfficiencyUnits : NSObject {
    open static let MilesPerGallon : String = "MilesPerGallon"
    open static let KilometerPerLiter : String = "KilometerPerLiter"
    open static let LitersPerHundredKilometers : String = "LitersPerHundredKilometers"
}

open class FuelEfficiencyCalculationMethod : NSObject {
    open static let Query : String = "Query"
    open static let EngineFuelRate : String = "EngineFuelRate"
    open static let MassAirFlow : String = "MassAirFlow"
    open static let Calculated : String = "Calculated"
    open static let None : String = "None"
}

open class FuelVolumeUnits : NSObject {
    open static let Gallon        : String = "Gallon"
    open static let Liter         : String = "Liter"
    open static let Gill          : String = "Gill"
    open static let Pint          : String = "Pint"
    open static let Quart         : String = "Quart"
    open static let Milliliter    : String = "Milliliter"
}
