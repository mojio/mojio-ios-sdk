//
//  Vehicle.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class Vehicle: Mappable {
    
    open dynamic var Name : String? = nil
    open dynamic var LicensePlate : String? = nil
    open dynamic var VIN : String? = nil
    open dynamic var DetectedVIN : String? = nil
    open dynamic var OverrideVIN : String? = nil
    open var CompatDetails: CompatibilityDetails? = nil
    open dynamic var CurrentTrip : String? = nil
    open dynamic var MojioId : String? = nil
    open var VehicleImage : Image? = nil
    open var MilStatus : Bool = false
    open dynamic var LastContactTime : String? = nil
    open var DiagnosticCodes : [DiagnosticCode] = []
    open var VehicleAccelerometer : Accelerometer? = nil
    open var VehicleAcceleration : Acceleration? = nil
    open var Deceleration : Acceleration? = nil
    open var VehicleSpeed : Speed? = nil
    open var VehicleOdometer : Odometer? = nil
    open var VirtualOdometer : Odometer? = nil
    open var VehicleRPM : RPM? = nil
    open var VehicleFuelEfficiency : FuelEfficiency? = nil
    
    // FuelEfficiencyCalculationMethod
    open dynamic var FuelEfficiencyCalculationMethod : String? = nil
    open var VehicleFuelLevel : FuelLevel? = nil
    open var VehicleFuelVolume : FuelVolume? = nil
    
    // FuelType
    open dynamic var FuelType : String? = nil
    open dynamic var GatewayTime : String? = nil
    open var VehicleHarshEventState : HarshEvent? = nil
    open var VehicleIdleState : IdleState? = nil
    open var VehicleIgnitionState : BooleanState? = nil
    open var VehicleBattery : Battery? = nil
    open var VehicleHeading : Heading? = nil
    open var VehicleLocation : Location? = nil
    open var VehicleAccidentState : BooleanState? = nil
    open var VehicleVinDetails : VinDetails? = nil
    open var VehicleTowState : BooleanState? = nil
    open var VehicleParkedState : BooleanState? = nil
    open var Tags : [String] = []
    open var OwnerGroups : [String] = []
    open dynamic var Id : String? = nil
    open dynamic var CreatedOn : String? = nil
    open dynamic var LastModified : String? = nil
    
    open var Deleted : Bool = false
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {}
    
    open static func primaryKey() -> String? {
        return "Id"
    }
    
    open func jsonVINDict () -> NSDictionary {
        let dictionary : NSMutableDictionary = NSMutableDictionary()

        if self.VIN != nil {
            dictionary.setObject(self.VIN!, forKey: "VIN" as NSCopying)
        }

        if let detectedVin = self.DetectedVIN {
            dictionary["DetectedVIN"] = detectedVin
        }
        
        if let overrideVIN = self.OverrideVIN {
            dictionary["OverrideVIN"] = overrideVIN
        }
        return dictionary
    }
    
    open func jsonDict () -> NSDictionary {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Name != nil {
            dictionary.setObject(self.Name!, forKey: "Name" as NSCopying)
        }
        if self.LicensePlate != nil {
            dictionary.setObject(self.LicensePlate!, forKey: "LicensePlate" as NSCopying)
        }

        if self.VehicleOdometer != nil {
            let odo = self.VehicleOdometer!.jsonDict()
            dictionary.setObject(odo, forKey: "Odometer" as NSCopying)
        }
        
        return dictionary
    }
    
    open func mapping(map: Map) {
        
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
