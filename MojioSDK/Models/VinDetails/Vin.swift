//
//  VIN.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

public class Vin: Object, Mappable {
    
    public dynamic var VIN : String? = nil
    public dynamic var Timestamp : String? = nil
    public dynamic var Market : String? = nil
    public var Year = RealmOptional<Int>()
    public dynamic var Make : String? = nil
    public dynamic var Model : String? = nil
    public dynamic var VehicleType : String? = nil
    public dynamic var BodyType : String? = nil
    public dynamic var DriveType : String? = nil
    public dynamic var FuelTankSize : Float = 0
    public dynamic var EPAFuelEfficiency : Float = 0
    public dynamic var VehicleEngine : Engine? = nil
    public dynamic var VehicleTransmission : Transmission? = nil
    public var Warranties = List<Warranty>()
    public var Recalls = List<Recall>()
    public var ServiceBulletins = List<ServiceBulletin>()
    
    public required convenience init?(_ map: Map) {
        self.init();
    }
    
    public override static func primaryKey() -> String? {
        return "VIN"
    }
    
    public func YearAsIntNumber() -> NSNumber {
        return self.Year.value! as NSNumber
    }
    
    public func WarrantiesArray() -> NSArray {
        return self.Warranties.toArray()
    }
    
    public func RecallsArray() -> NSArray {
        return self.Recalls.toArray()
    }
    
    public func ServiceBulletinsArray() -> NSArray {
        return self.ServiceBulletins.toArray()
    }
    
    public func mapping(map: Map) {
        
        var warranties = Array<Warranty>()
        warranties <- map["Warranties"]
        
        for warranty in warranties {
            self.Warranties.append(warranty)
        }
        
        var recalls = Array<Recall>()
        recalls <- map["Recalls"]
        
        for recall in recalls {
            self.Recalls.append(recall)
        }

        var serviceBulletins = Array<ServiceBulletin>()
        serviceBulletins <- map["ServiceBulletins"]
        
        for serviceBulletin in serviceBulletins {
            self.ServiceBulletins.append(serviceBulletin)
        }
        
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
        
    }    
}
