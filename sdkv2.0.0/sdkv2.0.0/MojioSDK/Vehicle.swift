//
//  Vehicle.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class Vehicle: Mappable {
    
    var Name : NSString?;
    var LicensePlate : NSString?;
    var VIN : NSString?;
    var CurrentTrip : NSString?;
    var MojioId : NSString?;
    var VehicleImage : Image?;
    var MilStatus : Bool?;
    var LastContactTime : NSString?;
    var DiagnosticCodes : [DiagnosticCode]?;
    var VehicleAccelerometer : Accelerometer?;
    var VehicleAcceleration : Acceleration?;
    var Deceleration : Acceleration?;
    var VehicleSpeed : Speed?;
    var VehicleOdometer : Odometer?;
    var VehicleRPM : RPM?;
    var VehicleFuelEfficiency : FuelEfficiency?;
    var FuelEfficiencyCalculationMethod  : NSString?; // ['Query', 'EngineFuelRate', 'MassAirFlow', 'Calculated', 'None'],
    var VehicleFuelLevel : FuelLevel?;
    var FuelType : NSString?; // ['Query', 'Gasoline', 'Diesel', 'Electric'],
    var GatewayTime : NSString?;
    var VehicleHarshEventState : HarshEventState?;
    var VehicleIdleState : IdleState?;
    var VehicleIgnitionState : IgnitionState?;
    var VehicleBattery : Battery?;
    var VehicleHeading : Heading?;
    var VehicleLocation : Location?;
    var VehicleAccidentState : AccidentState?;
    var VehicleVinDetails : VinDetails?;
    var VehicleTowState : TowState?;
    var VehicleParkedState : ParkedState?;
    var Tags : NSArray?;
    var OwnerGroups : NSArray?;
    var Id : NSString?;
    var CreatedOn : NSString?;
    var LastModified : NSString?;
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        Name <- map["Name"];
        LicensePlate <- map["LicensePlate"];
        VIN <- map["VIN"];
        CurrentTrip <- map["CurrentTrip"];
        MojioId <- map["MojioId"];
        VehicleImage <- map["Image"];
        MilStatus <- map["MilStatus"];
        LastContactTime <- map["LastContactTime"];
        DiagnosticCodes <- map["DiagnosticCodes"];
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
        Tags <- map["Tags"];
        OwnerGroups <- map["OwnerGroups"];
        Id <- map["Id"];
        CreatedOn <- map["CreatedOn"];
        LastModified <- map["LastModified"];
    }


}
