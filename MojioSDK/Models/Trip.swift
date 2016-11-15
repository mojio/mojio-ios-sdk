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

open class Trip: Mappable {
    open dynamic var VehicleId : String? = nil
    open dynamic var Name : String? = nil
    open var Tags : [String] = []
    open dynamic var MojioId : String? = nil
    open dynamic var Completed : Bool = false
    open dynamic var TripDuration : String? = nil
    open var TripDistance : Distance? = nil
    open dynamic var StartTimestamp : String? = nil
    open dynamic var EndTimestamp : String? = nil
    open var StartOdometer : Odometer? = nil
    open var EndOdometer : Odometer? = nil
    open var StartLocation : Location? = nil
    open var EndLocation : Location? = nil
    open var MaxSpeed : Speed? = nil
    open var MaxRPM : RPM? = nil
    open var MaxAcceleration : Acceleration? = nil
    open var MaxDeceleration : Acceleration? = nil
    open var TripFuelEfficiency : FuelEfficiency? = nil
    open var StartFuelLevel : FuelLevel? = nil
    open var EndFuelLevel : FuelLevel? = nil
    open var IdlingCount : Int? = nil
    open var HarshAccelCount : Int? = nil
    open var HarshDecelCount : Int? = nil
    open dynamic var Id : String? = nil
    open dynamic var CreatedOn : String? = nil
    open dynamic var LastModified : String? = nil

    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    open static func primaryKey() -> String? {
        return "Id"
    }
    
    open func json() -> String? {
        
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Name != nil {
            dictionary.setObject(self.Name!, forKey: "Name" as NSCopying)
        }
        
        let data = try! JSONSerialization.data(withJSONObject: dictionary, options:  JSONSerialization.WritingOptions.prettyPrinted)
        return NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
    }
    
    open func mapping(map: Map) {
                
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
        IdlingCount <- map["IdlingCount"];
        HarshAccelCount <- map["HarshAcclCount"];
        HarshDecelCount <- map["HarshDecelCount"];
        Id <- map["Id"];
        CreatedOn <- map["CreatedOn"];
        LastModified <- map["LastModified"];
        Tags <- map["Tags"]
    }
}
