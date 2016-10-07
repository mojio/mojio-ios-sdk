//
//  Trip.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

public class Trip: Mappable {
    public dynamic var VehicleId : String? = nil
    public dynamic var Name : String? = nil
    public var Tags : [String] = []
    public dynamic var MojioId : String? = nil
    public dynamic var Completed : Bool = false
    public dynamic var TripDuration : String? = nil
    public var TripDistance : Distance? = nil
    public dynamic var StartTimestamp : String? = nil
    public dynamic var EndTimestamp : String? = nil
    public var StartOdometer : Odometer? = nil
    public var EndOdometer : Odometer? = nil
    public var StartLocation : Location? = nil
    public var EndLocation : Location? = nil
    public var MaxSpeed : Speed? = nil
    public var MaxRPM : RPM? = nil
    public var MaxAcceleration : Acceleration? = nil
    public var MaxDeceleration : Acceleration? = nil
    public var TripFuelEfficiency : FuelEfficiency? = nil
    public var StartFuelLevel : FuelLevel? = nil
    public var EndFuelLevel : FuelLevel? = nil
    public dynamic var Id : String? = nil
    public dynamic var CreatedOn : String? = nil
    public dynamic var LastModified : String? = nil

    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    public static func primaryKey() -> String? {
        return "Id"
    }
    
    public func json() -> String? {
        
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Name != nil {
            dictionary.setObject(self.Name!, forKey: "Name")
        }
        
        let data = try! NSJSONSerialization.dataWithJSONObject(dictionary, options:  NSJSONWritingOptions.PrettyPrinted)
        return NSString(data: data, encoding: NSUTF8StringEncoding)! as String
    }
    
    public func mapping(map: Map) {
                
        VehicleId <- map["VehicleId"];
        Name <- map["Name"];
        MojioId <- map["MojioId"];
        Completed <- map["Completed"];
        TripDuration <- map["Duration"];
        TripDistance <- map["Distance"]
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
        Tags <- map["Tags"]

    }
}
