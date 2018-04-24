//
//  HarshEventState.swift
//  MojioSDK
//
//  Created by Suresh Venkatraman on 6/26/17.
//  Copyright © 2017 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public enum HarshEventType: String {
    case acceleration = "Acceleration"
    case deceleration = "Deceleration"
    case turning = "Turning"
    case upward = "Upward"
    case downward = "Downward"
    case accident = "Accident"
    case postAccident = "PostAccident"
}

public enum HarshEventTurnType: String {
    case left = "Left"
    case right = "Right"
}

public struct HarshEventState: Mappable {
    
    public var Timestamp: String? = nil
    public var Value: Bool = false
    public var EventType: String? = nil
    public var TurnType: String? = nil
    
    public var timestamp: Date? = nil
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }
    
    public mutating func mapping(map: Map) {
        Timestamp <- map["Timestamp"]
        Value <- map["Value"]
        EventType <- map["EventType"]
        TurnType <- map["TurnType"]
        
        timestamp = self.Timestamp?.toDate
    }
}
