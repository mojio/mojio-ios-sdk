//
//  HarshEvent.swift
//  MojioSDK
//
//  Created by Suresh Venkatraman on 9/21/16.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class HarshEventEventTypes : NSObject {
    public static let Acceleration : String = "Acceleration"
    public static let Deceleration : String = "Deceleration"
    public static let Turning : String = "Turning"
    public static let Upward : String = "Upward"
    public static let Downward : String = "Downward"
    public static let Accident : String = "Accident"
    public static let PostAccident : String = "PostAccident"
}

public class HarshEventTurnTypes : NSObject {
    public static let Left : String = "Left"
    public static let Right : String = "Right"
}

public class HarshEvent: Object, Mappable {
    
    public dynamic var Timestamp : String? = nil
    public dynamic var Value : Bool = false
    public dynamic var EventType : String? = nil
    public dynamic var TurnType : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        Timestamp <- map["Timestamp"];
        Value <- map["Value"];
        EventType <- map["EventType"];
        TurnType <- map["TurnType"];
    }
    
}