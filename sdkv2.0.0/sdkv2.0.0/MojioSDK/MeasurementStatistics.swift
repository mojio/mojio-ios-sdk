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

class MeasurementStatistics: Object, Mappable {
    
    var NumOfSamples : Float = 0
    var Average : Float = 0
    var Variance : Float = 0
    var StdDev : Float = 0
    var IndexOfDispersion : Float = 0
    var CoeffOfVariation : Float = 0
    var M2 : Float = 0
    var Min : Float = 0
    var Max : Float = 0
    dynamic var StandardScore : Score? = nil
    dynamic var MinMaxScore : Score? = nil
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
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
