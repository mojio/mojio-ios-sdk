//
//  Score.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class ScoreMethods {
    open static let ZScore : String = "ZScore"
    open static let MinMaxScore : String = "MinMaxScore"
}

open class Score: Mappable {
    
    // ScoreMethods
    open dynamic var ScoringMethod : String? = nil
    open dynamic var Value : Float = 0
    open dynamic var Percentile : Float = 0
    open dynamic var Average : Float = 0
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    open func mapping(map: Map) {
        ScoringMethod <- map["ScoringMethod"]
        Value <- map["Value"]
        Percentile <- map["Percentile"]
        Average <- map["Average"]
    }

}
