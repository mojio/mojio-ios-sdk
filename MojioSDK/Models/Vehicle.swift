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

import UIKit
import ObjectMapper

public struct Vehicle: Mappable, PrimaryKey {
    
    public var Name: String? = nil
    public var LicensePlate: String? = nil
    public var VIN: String? = nil
    public var DetectedVIN: String? = nil
    public var OverrideVIN: String? = nil
    public var CompatDetails: CompatibilityDetails? = nil
    public var CurrentTrip: String? = nil
    public var MojioId: String? = nil
    public var VehicleImage: Image? = nil
    public var MilStatus: Bool = false
    public var LastContactTime: String? = nil
    public var DiagnosticCodes: [DiagnosticCode] = []
    public var VehicleAccelerometer: Accelerometer? = nil
    public var VehicleAcceleration: Acceleration? = nil
    public var Deceleration: Acceleration? = nil
    public var VehicleSpeed: Speed? = nil
    public var VehicleOdometer: Odometer? = nil
    public var VirtualOdometer: Odometer? = nil
    public var VehicleRPM: RPM? = nil
    public var VehicleFuelEfficiency: FuelEfficiency? = nil
    
    // FuelEfficiencyCalculationMethod
    public var FuelEfficiencyCalculationMethod: String? = nil
    public var VehicleFuelLevel: FuelLevel? = nil
    public var VehicleFuelVolume: FuelVolume? = nil
    
    // FuelType
    public var FuelType: String? = nil
    public var GatewayTime: String? = nil
    public var VehicleHarshEventState: HarshEvent? = nil
    public var VehicleIdleState: IdleState? = nil
    public var VehicleIgnitionState: BooleanState? = nil
    public var VehicleBattery: Battery? = nil
    public var VehicleHeading: Heading? = nil
    public var VehicleLocation: Location? = nil
    public var VehicleAccidentState: BooleanState? = nil
    public var VehicleVinDetails: VinDetails? = nil
    public var VehicleTowState: BooleanState? = nil
    public var VehicleParkedState: BooleanState? = nil
    public var Tags: [String] = []
    public var OwnerGroups: [String] = []
    public var Id: String? = nil
    public var CreatedOn: String? = nil
    public var LastModified: String? = nil
    public var Deleted: Bool = false
    
    // Date Values
    public var lastContactTime: Date? = nil
    public var gatewayTime: Date? = nil
    public var createdOn: Date? = nil
    public var lastModified: Date? = nil
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }
    
    public func jsonVINDict () -> [String: Any] {
        
        var dictionary = [String: Any]()

        if let VIN = self.VIN {
            dictionary["VIN"] = VIN
        }

        if let detectedVin = self.DetectedVIN {
            dictionary["DetectedVIN"] = detectedVin
        }
        
        if let overrideVIN = self.OverrideVIN {
            dictionary["OverrideVIN"] = overrideVIN
        }
        
        return dictionary
    }
    
    public func jsonDict () -> [String: Any] {
        
        var dictionary = [String: Any]()
        
        if let name = self.Name {
            dictionary["Name"] = name
        }
        
        if let licensePlate = self.LicensePlate {
            dictionary["LicensePlate"] = licensePlate
        }

        if let vehicleOdometer = self.VehicleOdometer {
            dictionary["Odometer"] = vehicleOdometer.jsonDict()
        }
        
        return dictionary
    }
    
    public mutating func mapping(map: Map) {
        
        Name <- map["Name"]
        LicensePlate <- map["LicensePlate"]
        VIN <- map["VIN"]
        DetectedVIN <- map["DetectedVIN"]
        OverrideVIN <- map["OverrideVIN"]
        CompatDetails <- map["CompatDetails"]
        CurrentTrip <- map["CurrentTrip"]
        MojioId <- map["MojioId"]
        VehicleImage <- map["Image"]
        MilStatus <- map["MilStatus"]
        DiagnosticCodes <- map ["DiagnosticCodes"]
        LastContactTime <- map["LastContactTime"]
        VehicleAccelerometer <- map["Accelerometer"]
        VehicleAcceleration <- map["Acceleration"]
        Deceleration <- map["Deceleration"]
        VehicleSpeed <- map["Speed"]
        VehicleOdometer <- map["Odometer"]
        VirtualOdometer <- map["VirtualOdometer"]
        VehicleRPM <- map["RPM"]
        VehicleFuelEfficiency <- map["FuelEfficiency"]
        FuelEfficiencyCalculationMethod <- map["FuelEfficiencyCalculationMethod"]
        VehicleFuelLevel <- map["FuelLevel"]
        VehicleFuelVolume <- map["FuelVolume"]
        FuelType <- map["FuelType"]
        GatewayTime <- map["GatewayTime"]
        VehicleHarshEventState <- map["HarshEventState"]
        VehicleIdleState <- map["IdleState"]
        VehicleIgnitionState <- map["IgnitionState"]
        VehicleBattery <- map["Battery"]
        VehicleHeading <- map["Heading"]
        VehicleLocation <- map["Location"]
        VehicleAccidentState <- map["AccidentState"]
        VehicleVinDetails <- map["VinDetails"]
        VehicleTowState <- map["TowState"]
        VehicleParkedState <- map["ParkedState"]
        OwnerGroups <- map["OwnerGroups"]
        Id <- map["Id"]
        Tags <- map["Tags"]
        CreatedOn <- map["CreatedOn"]
        LastModified <- map["LastModified"]
        Deleted <- map["Deleted"]
    
        // Date Values
        lastContactTime = self.LastContactTime?.toDate
        gatewayTime = self.GatewayTime?.toDate
        createdOn = self.CreatedOn?.toDate
        lastModified = self.LastModified?.toDate
    }
}
