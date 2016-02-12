//
//  Trip.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class Trip: Mappable {
    var VehicleId : String?;
    var Name : String?;
    var Tags : NSArray?;
    var MojioId : String?;
    var Completed : Bool?;
    var Duration : String?;
    var StartTimestamp : String?;
    var EndTimestamp : String?;
    var StartOdometer : Odometer?
    var EndOdometer : Odometer?;
    var StartLocation : Location?;
    var EndLocation : Location?;
    var MaxSpeed : Speed?;
    var MaxRPM : RPM?;
    var MaxAcceleration : Acceleration?;
    var MaxDeceleration : Acceleration?;
    var TripFuelEfficiency : FuelEfficiency?;
    var StartFuelLevel : FuelLevel?;
    var EndFuelLevel : FuelLevel?;
    var Id : String?;
    var CreatedOn : String?;
    var LastModified : String?;

    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        VehicleId <- map["VehicleId"];
        Name <- map["Name"];
        Tags <- map["Tags"];
        MojioId <- map["MojioId"];
        Completed <- map["Completed"];
        Duration <- map["Duration"];
        StartTimestamp <- map["StartTimestamp"];
        EndTimestamp <- map["EndTimestamp"];
        StartOdometer <- map["StartOdometer"];
        EndOdometer <- map["EndOdometer"];
        StartLocation <- map["StartLocation"];
        EndLocation <- map["EndLocation"];
        MaxSpeed <- map["MaxSpeed"];
        MaxRPM <- map["MaxRPM"];
        MaxAcceleration <- map["MaxAcceleration"];
        MaxDeceleration <- map["MaxDeceleration"];
        TripFuelEfficiency <- map["FuelEfficiency"];
        StartFuelLevel <- map["StartFuelLevel"];
        EndFuelLevel <- map["EndFuelLevel"];
        Id <- map["Id"];
        CreatedOn <- map["CreatedOn"];
        LastModified <- map["LastModified"];
        
    }
}
