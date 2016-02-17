//
//  Trip.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Trip: Object, Mappable {
    dynamic var VehicleId : String? = nil
    dynamic var Name : String? = nil
    var Tags = List<StringObject>();
    dynamic var MojioId : String? = nil
    var Completed = RealmOptional<Bool>(false)
    dynamic var Duration : String? = nil
    dynamic var StartTimestamp : String? = nil
    dynamic var EndTimestamp : String? = nil
    dynamic var StartOdometer : Odometer? = nil
    dynamic var EndOdometer : Odometer? = nil
    dynamic var StartLocation : Location? = nil
    dynamic var EndLocation : Location? = nil
    dynamic var MaxSpeed : Speed? = nil
    dynamic var MaxRPM : RPM? = nil
    dynamic var MaxAcceleration : Acceleration? = nil
    dynamic var MaxDeceleration : Acceleration? = nil
    dynamic var TripFuelEfficiency : FuelEfficiency? = nil
    dynamic var StartFuelLevel : FuelLevel? = nil
    var EndFuelLevel : FuelLevel? = nil
    dynamic var Id : String? = nil
    dynamic var CreatedOn : String? = nil
    dynamic var LastModified : String? = nil

    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        var tags = Array<String>()
        tags <- map["Tags"]
        
        for tag in tags {
            let string = StringObject()
            string.value = tag
            
            self.Tags.append(string)
        }

        
        VehicleId <- map["VehicleId"];
        Name <- map["Name"];
//        Tags <- map["Tags"];
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
