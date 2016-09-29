//
//  FuelEfficiency.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class FuelEfficiencyUnits : NSObject {
    public static let MilesPerGallon : String = "MilesPerGallon"
    public static let KilometerPerLiter : String = "KilometerPerLiter"
    public static let LitersPerHundredKilometers : String = "LitersPerHundredKilometers"
}

public class FuelEfficiency: Mappable {
    
    public dynamic var BaseUnit : String? = nil
    public var Statistics : MeasurementStatistics? = nil
    public dynamic var BenchmarkTime : String? = nil
    public var BenchmarkStatistics : MeasurementStatistics? = nil
    public dynamic var Timestamp : String? = nil
    public dynamic var BaseValue : Float = 0
    
    // FuelEfficiencyUnits
    public dynamic var Unit  : String? = nil
    public dynamic var Value : Float = 0

    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    public func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"]
        Statistics <- map["Statistics"]
        BenchmarkTime <- map["BenchmarkTime"]
        BenchmarkStatistics <- map["BenchmarkStatistics"]
        Timestamp <- map["Timestamp"]
        BaseValue <- map["BaseValue"]
        Unit <- map["Unit"]
        Value <- map["Value"]
    }

}
