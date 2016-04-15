//
//  MeasurementStatistics.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class MeasurementStatistics: Object, Mappable {
    
    public dynamic var NumOfSamples : Float = 0
    public dynamic var Average : Float = 0
    public dynamic var Variance : Float = 0
    public dynamic var StdDev : Float = 0
    public dynamic var IndexOfDispersion : Float = 0
    public dynamic var CoeffOfVariation : Float = 0
    public dynamic var M2 : Float = 0
    public dynamic var Min : Float = 0
    public dynamic var Max : Float = 0
    public dynamic var StandardScore : Score? = nil
    public dynamic var MinMaxScore : Score? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        NumOfSamples <- map["NumOfSamples"];
        Average <- map["Average"];
        Variance <- map["Variance"];
        StdDev <- map["StdDev"];
        IndexOfDispersion <- map["IndexOfDispersion"];
        CoeffOfVariation <- map["CoeffOfVariation"];
        M2 <- map["M2"];
        Min <- map["Min"];
        Max <- map["Max"];
        StandardScore <- map["StandardScore"];
        MinMaxScore <- map["MinMaxScore"];
    }

}
