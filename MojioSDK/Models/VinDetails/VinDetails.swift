//
//  VinDetails.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class VinDetails: Object, Mappable {
    
    public dynamic var Timestamp : NSString? = nil
    public dynamic var Vin : NSString? = nil
    public var Year = RealmOptional<Int>()
    public dynamic var Make : NSString? = nil
    public dynamic var Model : NSString? = nil
    public dynamic var Engine : NSString? = nil
    public var Cylinders = RealmOptional<Int>()
    public dynamic var TotalFuelCapacity : FuelCapacity? = nil
    public dynamic var FuelType : NSString? = nil
    public var CityFuelEfficiency : Float = 0
    public var HighwayFuelEfficiency : Float = 0
    public var CombinedFuelEfficiency : Float = 0
    public dynamic var Transmission : NSString? = nil
    public dynamic var Message : NSString? = nil
    public var Success = RealmOptional<Bool>()
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
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
