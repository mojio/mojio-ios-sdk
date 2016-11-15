//
//  MeasurementStatistics.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class MeasurementStatistics: Mappable {
    
    open dynamic var NumOfSamples : Float = 0
    open dynamic var Average : Float = 0
    open dynamic var Variance : Float = 0
    open dynamic var StdDev : Float = 0
    open dynamic var IndexOfDispersion : Float = 0
    open dynamic var CoeffOfVariation : Float = 0
    open dynamic var M2 : Float = 0
    open dynamic var Min : Float = 0
    open dynamic var Max : Float = 0
    open var StandardScore : Score? = nil
    open var MinMaxScore : Score? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    open func mapping(map: Map) {
        NumOfSamples <- map["NumOfSamples"]
        Average <- map["Average"]
        Variance <- map["Variance"]
        StdDev <- map["StdDev"]
        IndexOfDispersion <- map["IndexOfDispersion"]
        CoeffOfVariation <- map["CoeffOfVariation"]
        M2 <- map["M2"]
        Min <- map["Min"]
        Max <- map["Max"]
        StandardScore <- map["StandardScore"]
        MinMaxScore <- map["MinMaxScore"]
    }

}
