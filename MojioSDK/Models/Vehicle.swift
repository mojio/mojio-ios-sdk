//
//  Vehicle.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class Vehicle: Object, Mappable {
    
    public dynamic var Name : String? = nil
    public dynamic var LicensePlate : String? = nil
    public dynamic var VIN : String? = nil
    public dynamic var CurrentTrip : String? = nil
    public dynamic var MojioId : String? = nil
    public dynamic var VehicleImage : Image? = nil
    public dynamic var MilStatus : Bool = false
    public dynamic var LastContactTime : String? = nil
    public var DiagnosticCodes = List<DiagnosticCode>()
    public dynamic var VehicleAccelerometer : Accelerometer? = nil
    public dynamic var VehicleAcceleration : Acceleration? = nil
    public dynamic var Deceleration : Acceleration? = nil
    public dynamic var VehicleSpeed : Speed? = nil
    public dynamic var VehicleOdometer : Odometer? = nil
    public dynamic var VehicleRPM : RPM? = nil
    public dynamic var VehicleFuelEfficiency : FuelEfficiency? = nil
    
    // FuelEfficiencyCalculationMethod
    public dynamic var FuelEfficiencyCalculationMethod : String? = nil
    public dynamic var VehicleFuelLevel : FuelLevel? = nil
    
    // FuelType
    public dynamic var FuelType : String? = nil
    public dynamic var GatewayTime : String? = nil
    public dynamic var VehicleHarshEventState : BooleanState? = nil
    public dynamic var VehicleIdleState : BooleanState? = nil
    public dynamic var VehicleIgnitionState : BooleanState? = nil
    public dynamic var VehicleBattery : Battery? = nil
    public dynamic var VehicleHeading : Heading? = nil
    public dynamic var VehicleLocation : Location? = nil
    public dynamic var VehicleAccidentState : BooleanState? = nil
    public dynamic var VehicleVinDetails : VinDetails? = nil
    public dynamic var VehicleTowState : BooleanState? = nil
    public dynamic var VehicleParkedState : BooleanState? = nil
    public var Tags = List<StringObject>()
    public var OwnerGroups = List<StringObject>()
    public dynamic var Id : String? = nil
    public dynamic var CreatedOn : String? = nil
    public dynamic var LastModified : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public override static func primaryKey() -> String? {
        return "Id"
    }
    
    public func DiagnosticCodesArray() -> NSArray {
        return self.DiagnosticCodes.toArray()
    }
    
    public func TagsArray() -> NSArray {
        return self.Tags.toArray()
    }
    
    public func OwnerGroupsArray() -> NSArray {
        return self.OwnerGroups.toArray()
    }
    
    public func jsonDict () -> NSDictionary {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Name != nil {
            dictionary.setObject(self.Name!, forKey: "Name")
        }
        if self.LicensePlate != nil {
            dictionary.setObject(self.LicensePlate!, forKey: "LicensePlate")
        }
        
        if self.VIN != nil {
            dictionary.setObject(self.VIN!, forKey: "VIN")
        }

        if self.VehicleOdometer != nil {
            let odo = self.VehicleOdometer!.toDictionary()
            dictionary.setObject(odo, forKey: "Odometer")
        }
        
        return dictionary
    }
    
    public func mapping(map: Map) {
        
        var diagnosticCodes = Array<DiagnosticCode>()
        diagnosticCodes <- map ["DiagnosticCodes"]
        
        for diagnosticCode in diagnosticCodes {
            self.DiagnosticCodes.append(diagnosticCode)
        }
        
        var tags = Array<String>()
        tags <- map["Tags"]
        
        for tag in tags {
            let string = StringObject()
            string.value = tag
            
            self.Tags.append(string)
        }
        
        var ownerGroups = Array<String>()
        ownerGroups <- map["OwnerGroups"]
        
        for ownerGroup in ownerGroups {
            let string = StringObject()
            string.value = ownerGroup
            
            self.OwnerGroups.append(string)
        }
        

        Name <- map["Name"];
        LicensePlate <- map["LicensePlate"];
        VIN <- map["VIN"];
        CurrentTrip <- map["CurrentTrip"];
        MojioId <- map["MojioId"];
        VehicleImage <- map["Image"];
        MilStatus <- map["MilStatus"];
        LastContactTime <- map["LastContactTime"];
        VehicleAccelerometer <- map["Accelerometer"];
        VehicleAcceleration <- map["Acceleration"];
        Deceleration <- map["Deceleration"];
        VehicleSpeed <- map["Speed"];
        VehicleOdometer <- map["Odometer"];
        VehicleRPM <- map["RPM"];
        VehicleFuelEfficiency <- map["FuelEfficiency"];
        FuelEfficiencyCalculationMethod <- map["FuelEfficiencyCalculationMethod"];
        VehicleFuelLevel <- map["FuelLevel"];
        FuelType <- map["FuelType"];
        GatewayTime <- map["GatewayTime"];
        VehicleHarshEventState <- map["HarshEventState"];
        VehicleIdleState <- map["IdleState"];
        VehicleIgnitionState <- map["IgnitionState"];
        VehicleBattery <- map["Battery"];
        VehicleHeading <- map["Heading"];
        VehicleLocation <- map["Location"];
        VehicleAccidentState <- map["AccidentState"];
        VehicleVinDetails <- map["VinDetails"];
        VehicleTowState <- map["TowState"];
        VehicleParkedState <- map["ParkedState"];
        Id <- map["Id"];
        CreatedOn <- map["CreatedOn"];
        LastModified <- map["LastModified"];
    }
}
