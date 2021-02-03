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
public enum RiskSeverity: String, Codable, Equatable {
    case unknown = "Unknown"
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    case critical = "Critical"
    case none = "None"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = RiskSeverity(rawValue: label) ?? .unknown
    }
}

// Distance
public enum DistanceUnit: String, Codable {
    
    case meters = "Meters"
    case miles = "Miles"
    case kilometers = "Kilometers"
    case nauticalMiles = "NauticalMiles"
    case centiMeter = "CentiMeter"
    case milliMeter = "MilliMeter"
    case unknown = "Unknown"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = DistanceUnit(rawValue: label) ?? .unknown
    }
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
    case unknown = "Unknown"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = TimePeriodUnit(rawValue: label) ?? .unknown
    }
}

// Speed
public enum SpeedUnit: String, Codable {
    case kilometersPerHour = "KilometersPerHour"
    case milesPerHour = "MilesPerHour"
    case unknown = "Unknown"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = SpeedUnit(rawValue: label) ?? .unknown
    }
}

// Acceleration
public enum AccelerationUnit: String, Codable {
    case metersPerSecondPerSecond = "MetersPerSecondPerSecond"
    case kilometersPerHourPerSecond  = "KilometersPerHourPerSecond"
    case milesPerHourPerSecond = "MilesPerHourPerSecond"
    case unknown = "Unknown"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = AccelerationUnit(rawValue: label) ?? .unknown
    }
}

// Percent
public enum PercentageUnit: String, Codable {
    case percentage = "Percentage"
    case unknown = "Unknown"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = PercentageUnit(rawValue: label) ?? .unknown
    }
}

// RPM
public enum RPMUnit: String, Codable {
    case revolutionsPerMinute = "RevolutionsPerMinute"
    case unknown = "Unknown"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = RPMUnit(rawValue: label) ?? .unknown
    }
}

// Accelerometer
public enum AccelerometerUnit: String, Codable  {
    case milliGUnits = "MilliGUnits"
    case newtonsPerKilogram = "NewtonsPerKilogram"
    case xirgoUnit = "XirgoUnit"
    case metersPerSecondPerSecond = "MetersPerSecondPerSecond"
    case centimetersPerSecondPerSecond = "CentimetersPerSecondPerSecond"
    case gUnits = "GUnits"
    case unknown = "Unknown"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = AccelerometerUnit(rawValue: label) ?? .unknown
    }
}

// Battery
public enum BatteryVoltageUnit: String, Codable {
    case milliVolts = "MilliVolts"
    case volts = "Volts"
    case unknown = "Unknown"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = BatteryVoltageUnit(rawValue: label) ?? .unknown
    }
}

public enum BatteryAmperageUnit: String, Codable {
    case milliamps = "Milliamps"
    case amps = "Amps"
    case unknown = "Unknown"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = BatteryAmperageUnit(rawValue: label) ?? .unknown
    }
}

// Fuel
public enum FuelType: String, Codable {
    case query = "Query"
    case gasoline = "Gasoline"
    case diesel = "Diesel"
    case electric = "Electric"
    case unknown = "Unknown"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = FuelType(rawValue: label) ?? .unknown
    }
}

public enum FuelCapacityUnit: String, Codable {
    case gallons = "Gallons"
    case liters = "Liters"
    case unknown = "Unknown"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = FuelCapacityUnit(rawValue: label) ?? .unknown
    }
}

public enum FuelEfficiencyUnit: String, Codable {
    case milesPerGallon = "MilesPerGallon"
    case kilometerPerLiter = "KilometerPerLiter"
    case litersPerHundredKilometers = "LitersPerHundredKilometers"
    case unknown = "Unknown"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = FuelEfficiencyUnit(rawValue: label) ?? .unknown
    }
}

public enum FuelEfficiencyCalculationMethod: String, Codable {
    case query = "Query"
    case engineFuelRate = "EngineFuelRate"
    case massAirFlow = "MassAirFlow"
    case calculated = "Calculated"
    case none = "None"
    case unknown = "Unknown"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = FuelEfficiencyCalculationMethod(rawValue: label) ?? .unknown
    }
}

public enum FuelVolumeUnit: String, Codable {
    case gallon = "Gallon"
    case liter = "Liter"
    case gill = "Gill"
    case pint = "Pint"
    case quart = "Quart"
    case milliliter = "Milliliter"
    case unknown = "Unknown"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = FuelVolumeUnit(rawValue: label) ?? .unknown
    }
}

public enum TemperatureUnit: String, Codable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case unknown = "Unknown"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = TemperatureUnit(rawValue: label) ?? .unknown
    }
}
