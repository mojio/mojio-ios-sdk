//
//  VIN.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class Vin: Mappable {
    
    open dynamic var VIN : String? = nil
    open dynamic var Timestamp : String? = nil
    open dynamic var Market : String? = nil
    open var Year : Int = 0
    open dynamic var Make : String? = nil
    open dynamic var Model : String? = nil
    open dynamic var VehicleType : String? = nil
    open dynamic var BodyType : String? = nil
    open dynamic var DriveType : String? = nil
    open dynamic var FuelTankSize : Float = 0
    open dynamic var EPAFuelEfficiency : Float = 0
    open var VehicleEngine : Engine? = nil
    open var VehicleTransmission : Transmission? = nil
    open var Warranties : [Warranty] = []
    open var Recalls : [Recall] = []
    open var ServiceBulletins : [ServiceBulletin] = []
    
    public required convenience init?(map: Map) {
        self.init();
    }
    
    public required init() {
        
    }

    open static func primaryKey() -> String? {
        return "VIN"
    }
        
    open func WarrantiesArray() -> NSArray {
        return self.Warranties as NSArray
    }
    
    open func mapping(map: Map) {
        
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
