//
//  Score.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class ScoreMethods {
    public static let ZScore : String = "ZScore"
    public static let MinMaxScore : String = "MinMaxScore"
}

public class Score: Mappable {
    
    // ScoreMethods
    public dynamic var ScoringMethod : String? = nil
    public dynamic var Value : Float = 0
    public dynamic var Percentile : Float = 0
    public dynamic var Average : Float = 0
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    public func mapping(map: Map) {
        ScoringMethod <- map["ScoringMethod"]
        Value <- map["Value"]
        Percentile <- map["Percentile"]
        Average <- map["Average"]
    }

}
