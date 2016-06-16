//
//  VinDetails.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class VinDetails: Object, Mappable {
    
    public dynamic var Timestamp : String? = nil
    public dynamic var Vin : String? = nil
    public var Year = RealmOptional<Int>()
    public dynamic var Make : String? = nil
    public dynamic var Model : String? = nil
    public dynamic var Engine : String? = nil
    public var Cylinders = RealmOptional<Int>()
    public dynamic var TotalFuelCapacity : FuelCapacity? = nil
    public dynamic var FuelType : String? = nil
    public var CityFuelEfficiency : Float = 0
    public var HighwayFuelEfficiency : Float = 0
    public var CombinedFuelEfficiency : Float = 0
    public dynamic var Transmission : String? = nil
    public dynamic var Message : String? = nil
    public var Success = RealmOptional<Bool>()
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func YearAsIntNumber() -> NSNumber {
        return self.Year.value! as NSNumber
    }
    
    public func CylindersIntNumber() -> NSNumber {
        return self.Cylinders.value! as NSNumber
    }
    
    public func mapping(map: Map) {
        Timestamp <- map["Timestamp"];
        Vin <- map["Vin"];
        Year <- map["Year"];
        Make <- map["Make"];
        Model <- map["Model"];
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
