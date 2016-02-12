//
//  Score.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class Score: Mappable {
    
    var ScoringMethod : NSString?; // ['ZScore', 'MinMaxScore']
    var Value : NSNumber?;
    var Percentile : NSNumber?;
    var Average : NSNumber?;
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        ScoringMethod <- map["ScoringMethod"];
        Value <- map["Value"];
        Percentile <- map["Percentile"];
        Average <- map["Average"];
    }

}
