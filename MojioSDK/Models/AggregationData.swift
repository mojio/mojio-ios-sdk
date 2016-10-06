//
//  AggregationData.swift
//  MojioSDK
//
//  Created by Oleksii Lubianyi on 10/3/16.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation
import ObjectMapper

public class AggregationDataMeasurementType: NSObject {
    
    public static let MeasureBattery : String = "battery"
}

public class AggregationData: Mappable {

    public dynamic var Total        : Float = 0
    public dynamic var Average      : Float = 0
    public dynamic var Max          : Float = 0
    public dynamic var Min          : Float = 0
    public dynamic var Units        : String?
    public dynamic var Date         : String?
    public dynamic var EndDate      : String?
    public dynamic var Count        : Int = 0
    public dynamic var TripCount    : Int = 0
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        Total       <- map["Total"]
        Average     <- map["Average"]
        Max         <- map["Max"]
        Min         <- map["Min"]
        Units       <- map["Units"]
        Date        <- map["Date"]
        EndDate     <- map["EndDate"]
        Count       <- map["Count"]
        TripCount   <- map["TripCount"]
    }
}
