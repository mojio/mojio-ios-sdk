//
//  AggregationData.swift
//  MojioSDK
//
//  Created by Oleksii Lubianyi on 10/3/16.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation
import ObjectMapper

open class AggregationDataMeasurementType: NSObject {
    
    open static let MeasureBattery : String = "battery"
}

open class AggregationData: Mappable {

    open dynamic var Total        : Float = 0
    open dynamic var Average      : Float = 0
    open dynamic var Max          : Float = 0
    open dynamic var Min          : Float = 0
    open dynamic var Units        : String?
    open dynamic var Date         : String?
    open dynamic var EndDate      : String?
    open dynamic var Count        : Int = 0
    open dynamic var TripCount    : Int = 0
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    open func mapping(map: Map) {
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
