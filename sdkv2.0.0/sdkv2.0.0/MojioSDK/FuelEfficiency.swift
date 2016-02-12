//
//  FuelEfficiency.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class FuelEfficiency: Mappable {
    
    var BaseUnit : NSString?; // ['MilesPerGallon', 'KilometerPerLiter', 'LitersPerHundredKilometers']
    var Statistics : MeasurementStatistics?;
    var BenchmarkTime : NSString?;
    var BenchmarkStatistics : MeasurementStatistics?;
    var Timestamp : NSString?;
    var BaseValue : NSNumber?;
    var Unit  : NSString?; // ['MilesPerGallon', 'KilometerPerLiter', 'LitersPerHundredKilometers'],
    var Value : NSNumber?;

    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"];
        Statistics <- map["Statistics"];
        BenchmarkTime <- map["BenchmarkTime"];
        BenchmarkStatistics <- map["BenchmarkStatistics"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }

}
