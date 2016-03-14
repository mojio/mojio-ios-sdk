//
//  Vehicle.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Vehicle: Object, Mappable {
    
    dynamic var Name : NSString? = nil
    dynamic var LicensePlate : NSString? = nil
    dynamic var VIN : NSString? = nil
    dynamic var CurrentTrip : NSString? = nil
    dynamic var MojioId : NSString? = nil
    dynamic var VehicleImage : Image? = nil
    var MilStatus = RealmOptional<Bool>()
    dynamic var LastContactTime : NSString? = nil
    var DiagnosticCodes = List<DiagnosticCode>()
    dynamic var VehicleAccelerometer : Accelerometer? = nil
    dynamic var VehicleAcceleration : Acceleration? = nil
    dynamic var Deceleration : Acceleration? = nil
    dynamic var VehicleSpeed : Speed? = nil
    dynamic var VehicleOdometer : Odometer? = nil
    dynamic var VehicleRPM : RPM? = nil
    dynamic var VehicleFuelEfficiency : FuelEfficiency? = nil
    dynamic var FuelEfficiencyCalculationMethod  : NSString? = nil // ['Query', 'EngineFuelRate', 'MassAirFlow', 'Calculated', 'None'],
    dynamic var VehicleFuelLevel : FuelLevel? = nil
    dynamic var FuelType : NSString? = nil // ['Query', 'Gasoline', 'Diesel', 'Electric'],
    dynamic var GatewayTime : NSString? = nil
    dynamic var VehicleHarshEventState : BooleanState? = nil
    dynamic var VehicleIdleState : BooleanState? = nil
    dynamic var VehicleIgnitionState : BooleanState? = nil
    dynamic var VehicleBattery : Battery? = nil
    dynamic var VehicleHeading : Heading? = nil
    dynamic var VehicleLocation : Location? = nil
    dynamic var VehicleAccidentState : BooleanState? = nil
    dynamic var VehicleVinDetails : VinDetails? = nil
    dynamic var VehicleTowState : BooleanState? = nil
    dynamic var VehicleParkedState : BooleanState? = nil
    var Tags = List<StringObject>()
    var OwnerGroups = List<StringObject>()
    dynamic var Id : NSString? = nil
    dynamic var CreatedOn : NSString? = nil
    dynamic var LastModified : NSString? = nil
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "Id"
    }
    
    func json () -> NSString? {
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
        
        if dictionary.count == 0 {
            return nil
        }
        
        let data = try! NSJSONSerialization.dataWithJSONObject(dictionary, options:  NSJSONWritingOptions.PrettyPrinted)
        let string : NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
        return string
    }
    
    func mapping(map: Map) {
        
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
