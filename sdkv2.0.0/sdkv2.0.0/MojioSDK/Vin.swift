//
//  VIN.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class Vin: Object, Mappable {
    
    dynamic var VIN : String? = nil
    dynamic var Timestamp : String? = nil
    dynamic var Market : String? = nil
    var Year = RealmOptional<Int>()
    dynamic var Make : String? = nil
    dynamic var Model : String? = nil
    dynamic var VehicleType : String? = nil
    dynamic var BodyType : String? = nil
    dynamic var DriveType : String? = nil
    var FuelTankSize : Float = 0
    var EPAFuelEfficiency : Float = 0
    dynamic var VehicleEngine : Engine? = nil
    dynamic var VehicleTransmission : Transmission? = nil
    var Warranties = List<Warranty>()
    var Recalls = List<Recall>()
    var ServiceBulletins = List<ServiceBulletin>()
    
    required convenience init?(_ map: Map) {
        self.init();
    }
    
    func mapping(map: Map) {
        
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
