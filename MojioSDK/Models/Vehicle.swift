//
//  Vehicle.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class Vehicle: Mappable {
    
    public dynamic var Name : String? = nil
    public dynamic var LicensePlate : String? = nil
    public dynamic var VIN : String? = nil
    public dynamic var DetectedVIN : String? = nil
    public dynamic var OverrideVIN : String? = nil
    public dynamic var CurrentTrip : String? = nil
    public dynamic var MojioId : String? = nil
    public var VehicleImage : Image? = nil
    public var MilStatus : Bool = false
    public dynamic var LastContactTime : String? = nil
    public var DiagnosticCodes : [DiagnosticCode] = []
    public var VehicleAccelerometer : Accelerometer? = nil
    public var VehicleAcceleration : Acceleration? = nil
    public var Deceleration : Acceleration? = nil
    public var VehicleSpeed : Speed? = nil
    public var VehicleOdometer : Odometer? = nil
    public var VehicleRPM : RPM? = nil
    public var VehicleFuelEfficiency : FuelEfficiency? = nil
    
    // FuelEfficiencyCalculationMethod
    public dynamic var FuelEfficiencyCalculationMethod : String? = nil
    public var VehicleFuelLevel : FuelLevel? = nil
    public var VehicleFuelVolume : FuelVolume? = nil
    
    // FuelType
    public dynamic var FuelType : String? = nil
    public dynamic var GatewayTime : String? = nil
    public var VehicleHarshEventState : HarshEvent? = nil
    public var VehicleIdleState : IdleState? = nil
    public var VehicleIgnitionState : BooleanState? = nil
    public var VehicleBattery : Battery? = nil
    public var VehicleHeading : Heading? = nil
    public var VehicleLocation : Location? = nil
    public var VehicleAccidentState : BooleanState? = nil
    public var VehicleVinDetails : VinDetails? = nil
    public var VehicleTowState : BooleanState? = nil
    public var VehicleParkedState : BooleanState? = nil
    public var Tags : [String] = []
    public var OwnerGroups : [String] = []
    public dynamic var Id : String? = nil
    public dynamic var CreatedOn : String? = nil
    public dynamic var LastModified : String? = nil
    
    public var Deleted : Bool = false
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {}
    
    public static func primaryKey() -> String? {
        return "Id"
    }
    
    public func jsonVINDict () -> NSDictionary {
        let dictionary : NSMutableDictionary = NSMutableDictionary()

        if self.VIN != nil {
            dictionary.setObject(self.VIN!, forKey: "VIN")
        }

        if let detectedVin = self.DetectedVIN {
            dictionary["DetectedVIN"] = detectedVin
        }
        
        if let overrideVIN = self.OverrideVIN {
            dictionary["OverrideVIN"] = overrideVIN
        }
        return dictionary
    }
    
    public func jsonDict () -> NSDictionary {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Name != nil {
            dictionary.setObject(self.Name!, forKey: "Name")
        }
        if self.LicensePlate != nil {
            dictionary.setObject(self.LicensePlate!, forKey: "LicensePlate")
        }

        if self.VehicleOdometer != nil {
            let odo = self.VehicleOdometer!.jsonDict()
            dictionary.setObject(odo, forKey: "Odometer")
        }
        
        return dictionary
    }
    
    public func mapping(map: Map) {
        
        Name <- map["Name"]
        LicensePlate <- map["LicensePlate"]
        VIN <- map["VIN"]
        DetectedVIN <- map["DetectedVIN"]
        OverrideVIN <- map["OverrideVIN"]
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
        VehicleHeading <- map["Heading"];
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
    
    }
}
