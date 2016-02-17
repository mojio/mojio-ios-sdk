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
    
    var NumOfSamples = RealmOptional<Double>()
    var Average = RealmOptional<Double>()
    var Variance = RealmOptional<Double>()
    var StdDev = RealmOptional<Double>()
    var IndexOfDispersion = RealmOptional<Double>()
    var CoeffOfVariation = RealmOptional<Double>()
    var M2 = RealmOptional<Double>()
    var Min = RealmOptional<Double>()
    var Max = RealmOptional<Double>()
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
