//
//  Score.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Score: Object, Mappable {
    
    dynamic var ScoringMethod : NSString? = nil // ['ZScore', 'MinMaxScore']
    dynamic var Value : Float = 0
    dynamic var Percentile : Float = 0
    dynamic var Average : Float = 0
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        ScoringMethod <- map["ScoringMethod"];
        Value <- map["Value"];
        Percentile <- map["Percentile"];
        Average <- map["Average"];
    }

}
