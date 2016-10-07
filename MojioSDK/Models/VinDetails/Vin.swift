//
//  VIN.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class Vin: Mappable {
    
    public dynamic var VIN : String? = nil
    public dynamic var Timestamp : String? = nil
    public dynamic var Market : String? = nil
    public var Year : Int = 0
    public dynamic var Make : String? = nil
    public dynamic var Model : String? = nil
    public dynamic var VehicleType : String? = nil
    public dynamic var BodyType : String? = nil
    public dynamic var DriveType : String? = nil
    public dynamic var FuelTankSize : Float = 0
    public dynamic var EPAFuelEfficiency : Float = 0
    public var VehicleEngine : Engine? = nil
    public var VehicleTransmission : Transmission? = nil
    public var Warranties : [Warranty] = []
    public var Recalls : [Recall] = []
    public var ServiceBulletins : [ServiceBulletin] = []
    
    public required convenience init?(_ map: Map) {
        self.init();
    }
    
    public required init() {
        
    }

    public static func primaryKey() -> String? {
        return "VIN"
    }
        
    public func WarrantiesArray() -> NSArray {
        return self.Warranties
    }
    
    public func mapping(map: Map) {
        
        VIN <- map["VIN"]
        Timestamp <- map["Timestamp"]
        Market <- map["Market"]
        Year <- map["Year"]
        Make <- map["Make"]
        Model <- map["Model"]
        VehicleType <- map["VehicleType"]
        BodyType <- map["BodyType"]
        DriveType <- map["DriveType"]
        FuelTankSize <- map["FuelTankSize"]
        EPAFuelEfficiency <- map["EPAFuelEfficiency"]
        VehicleEngine <- map["Engine"]
        VehicleTransmission <- map["Transmission"]
        Warranties <- map["Warranties"]
        Recalls <- map["Recalls"]
        ServiceBulletins <- map["ServiceBulletins"]

    }
}
