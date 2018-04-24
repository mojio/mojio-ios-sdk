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
public enum RiskSeverity: String {
    case unknown = "Unknown"
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    case none = "None"
}

// Distance
public enum DistanceUnit: String {
    case meters = "Meters"
    case miles = "Miles"
    case kilometers = "Kilometers"
    case nauticalMiles = "NauticalMiles"
    case centiMeter = "CentiMeter"
    case milliMeter = "MilliMeter"
}

// Time
public enum TimePeriodUnit: String {
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
public enum SpeedUnit: String {
    case kilometersPerHour = "KilometersPerHour"
    case milesPerHour = "MilesPerHour"
}

// Acceleration
public enum AccelerationUnit: String {
    case metersPerSecondPerSecond = "MetersPerSecondPerSecond"
    case kilometersPerHourPerSecond  = "KilometersPerHourPerSecond"
    case milesPerHourPerSecond = "MilesPerHourPerSecond"
}

// Percent
public enum PercentageUnit: String {
    case percentage = "Percentage"
}

// RPM
public enum RPMUnit: String {
    case revolutionsPerMinute = "RevolutionsPerMinute"
}

// Accelerometer
public enum AccelerometerUnit: String  {
    case milliGUnits = "MilliGUnits"
    case newtonsPerKilogram = "NewtonsPerKilogram"
    case xirgoUnit = "XirgoUnit"
    case metersPerSecondPerSecond = "MetersPerSecondPerSecond"
    case centimetersPerSecondPerSecond = "CentimetersPerSecondPerSecond"
    case gUnits = "GUnits"
}

// Battery
public enum BatteryVoltageUnit: String {
    case milliVolts = "MilliVolts"
    case volts = "Volts"
}

// Fuel
public enum FuelType: String {
    case query = "Query"
    case gasoline = "Gasoline"
    case diesel = "Diesel"
    case electric = "Electric"
}

public enum FuelCapacityUnit: String {
    case gallons = "Gallons"
    case liters = "Liters"
}

public enum FuelEfficiencyUnit: String {
    case milesPerGallon = "MilesPerGallon"
    case kilometerPerLiter = "KilometerPerLiter"
    case litersPerHundredKilometers = "LitersPerHundredKilometers"
}

public enum FuelEfficiencyCalculationMethod: String {
    case query = "Query"
    case engineFuelRate = "EngineFuelRate"
    case massAirFlow = "MassAirFlow"
    case calculated = "Calculated"
    case none = "None"
}

public enum FuelVolumeUnit: String {
    case gallon = "Gallon"
    case liter = "Liter"
    case gill = "Gill"
    case pint = "Pint"
    case quart = "Quart"
    case milliliter = "Milliliter"
}
