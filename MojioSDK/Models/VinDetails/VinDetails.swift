//
//  VinDetails.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class VinDetails: Mappable {
    
    open dynamic var Timestamp : String? = nil
    open dynamic var Vin : String? = nil
    open var Year : Int = 0
    open dynamic var Make : String? = nil
    open dynamic var Model : String? = nil
    open dynamic var Engine : String? = nil
    open var Cylinders : Int? = nil
    open  var TotalFuelCapacity : FuelCapacity? = nil
    open dynamic var FuelType : String? = nil
    open var CityFuelEfficiency : Float = 0
    open var HighwayFuelEfficiency : Float = 0
    open var CombinedFuelEfficiency : Float = 0
    open dynamic var Transmission : String? = nil
    open dynamic var Message : String? = nil
    open var Success : Bool? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {
        
    }
    
    open func mapping(map: Map) {
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
