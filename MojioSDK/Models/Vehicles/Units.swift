/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2017 Copyright Moj.io Inc.
 * All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains, the property of
 * Moj.io Inc. and its suppliers, if any.  The intellectual and technical
 * concepts contained herein are proprietary to Moj.io Inc. and its suppliers
 * and may be covered by Patents, pending patents, and are protected by trade
 * secret or copyright law.
 *
 * Dissemination of this information or reproduction of this material is strictly
 * forbidden unless prior written permission is obtained from Moj.io Inc.
 *******************************************************************************/

import Foundation

// Risk Severity
public enum RiskSeverity: String, Codable {
    case unknown = "Unknown"
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    case none = "None"
}

// Distance
public enum DistanceUnit: String, Codable {
    case meters = "Meters"
    case miles = "Miles"
    case kilometers = "Kilometers"
    case nauticalMiles = "NauticalMiles"
    case centiMeter = "CentiMeter"
    case milliMeter = "MilliMeter"
}

// Time
public enum TimePeriodUnit: String, Codable {
    case ticks = "Ticks"
    case milliseconds = "Milliseconds"
    case seconds = "Seconds"
    case minutes = "Minutes"
    case hours = "Hours"
    case days = "Days"
    case weeks = "Weeks"
    case months = "Months"
    case years = "Years"
}

// Speed
public enum SpeedUnit: String, Codable {
    case kilometersPerHour = "KilometersPerHour"
    case milesPerHour = "MilesPerHour"
}

// Acceleration
public enum AccelerationUnit: String, Codable {
    case metersPerSecondPerSecond = "MetersPerSecondPerSecond"
    case kilometersPerHourPerSecond  = "KilometersPerHourPerSecond"
    case milesPerHourPerSecond = "MilesPerHourPerSecond"
}

// Percent
public enum PercentageUnit: String, Codable {
    case percentage = "Percentage"
}

// RPM
public enum RPMUnit: String, Codable {
    case revolutionsPerMinute = "RevolutionsPerMinute"
}

// Accelerometer
public enum AccelerometerUnit: String, Codable  {
    case milliGUnits = "MilliGUnits"
    case newtonsPerKilogram = "NewtonsPerKilogram"
    case xirgoUnit = "XirgoUnit"
    case metersPerSecondPerSecond = "MetersPerSecondPerSecond"
    case centimetersPerSecondPerSecond = "CentimetersPerSecondPerSecond"
    case gUnits = "GUnits"
}

// Battery
public enum BatteryVoltageUnit: String, Codable {
    case milliVolts = "MilliVolts"
    case volts = "Volts"
}

// Fuel
public enum FuelType: String, Codable {
    case query = "Query"
    case gasoline = "Gasoline"
    case diesel = "Diesel"
    case electric = "Electric"
}

public enum FuelCapacityUnit: String, Codable {
    case gallons = "Gallons"
    case liters = "Liters"
}

public enum FuelEfficiencyUnit: String, Codable {
    case milesPerGallon = "MilesPerGallon"
    case kilometerPerLiter = "KilometerPerLiter"
    case litersPerHundredKilometers = "LitersPerHundredKilometers"
}

public enum FuelEfficiencyCalculationMethod: String, Codable {
    case query = "Query"
    case engineFuelRate = "EngineFuelRate"
    case massAirFlow = "MassAirFlow"
    case calculated = "Calculated"
    case none = "None"
}

public enum FuelVolumeUnit: String, Codable {
    case gallon = "Gallon"
    case liter = "Liter"
    case gill = "Gill"
    case pint = "Pint"
    case quart = "Quart"
    case milliliter = "Milliliter"
}
