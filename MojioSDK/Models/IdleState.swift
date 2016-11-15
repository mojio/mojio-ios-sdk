//
//  IdleState.swift
//  MojioSDK
//
//  Created by Suresh Venkatraman on 9/21/16.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class IdleState: Mappable {
    
    open dynamic var Timestamp : String? = nil
    open dynamic var Value : Bool = false
    open dynamic var StartTime : String? = nil
    open var Duration : TimePeriod? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    open func mapping(map: Map) {
        Timestamp <- map["Timestamp"]
        Value <- map["Value"]
        StartTime <- map["StartTime"]
        Duration <- map["Duration"]
    }
    
}

