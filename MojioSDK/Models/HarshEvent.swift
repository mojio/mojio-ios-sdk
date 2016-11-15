//
//  HarshEvent.swift
//  MojioSDK
//
//  Created by Suresh Venkatraman on 9/21/16.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class HarshEventEventTypes : NSObject {
    open static let Acceleration : String = "Acceleration"
    open static let Deceleration : String = "Deceleration"
    open static let Turning : String = "Turning"
    open static let Upward : String = "Upward"
    open static let Downward : String = "Downward"
    open static let Accident : String = "Accident"
    open static let PostAccident : String = "PostAccident"
}

open class HarshEventTurnTypes : NSObject {
    open static let Left : String = "Left"
    open static let Right : String = "Right"
}

open class HarshEvent: Mappable {
    
    open dynamic var Timestamp : String? = nil
    open dynamic var Value : Bool = false
    open dynamic var EventType : String? = nil
    open dynamic var TurnType : String? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    open func mapping(map: Map) {
        Timestamp <- map["Timestamp"];
        Value <- map["Value"];
        EventType <- map["EventType"];
        TurnType <- map["TurnType"];
    }
    
}
