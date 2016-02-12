//
//  MeasurementStatistics.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class MeasurementStatistics: Mappable {
    
    var NumOfSamples : NSNumber?;
    var Average : NSNumber?;
    var Variance : NSNumber?;
    var StdDev : NSNumber?;
    var IndexOfDispersion : NSNumber?;
    var CoeffOfVariation : NSNumber?;
    var M2 : NSNumber?;
    var Min : NSNumber?;
    var Max : NSNumber?;
    var StandardScore : Score?;
    var MinMaxScore : Score?;
    
    required init?(_ map: Map) {
        
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
