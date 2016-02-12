//
//  VinDetails.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class VinDetails: Mappable {
    
    var Timestamp : NSString?;
    var Vin : NSString?;
    var Year : NSInteger?;
    var Make : NSString?;
    var Model : NSString?;
    var Engine : NSString?;
    var Cylinders : NSInteger?;
    var TotalFuelCapacity : FuelCapacity?;
    var FuelType : NSString?;
    var CityFuelEfficiency : NSNumber?;
    var HighwayFuelEfficiency : NSNumber?;
    var CombinedFuelEfficiency : NSNumber?;
    var Transmission : NSString?;
    var Message : NSString?;
    var Success : Bool?;
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        Timestamp <- map["Timestamp"];
        Vin <- map["Vin"];
        Year <- map["Year"];
        Make <- map["Make"];
        Model <- map[""];
        Engine <- map["Engine"];
        Cylinders <- map["Cylinders"];
        TotalFuelCapacity <- map["TotalFuelCapacity"];
        FuelType <- map["FuelType"];
        CityFuelEfficiency <- map["CityFuelEfficiency"];
        HighwayFuelEfficiency <- map["HighwayFuelEfficiency"];
        CombinedFuelEfficiency <- map["CombinedFuelEfficiency"];
        Transmission <- map["Transmission"];
        Message <- map["Message"];
        Success <- map["Success"];
    }
}
