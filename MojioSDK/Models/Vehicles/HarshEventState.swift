//
//  HarshEventState.swift
//  MojioSDK
//
//  Created by Suresh Venkatraman on 6/26/17.
//  Copyright © 2017 Mojio. All rights reserved.
//

import Foundation

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

public struct HarshEventState: Codable {
    
    public let timestampString: String?
    public let value: Bool
    public let eventType: String?
    public let turnType: String?
    
    public enum CodingKeys: String, CodingKey {
        case timestampString = "Timestamp"
        case value = "Value"
        case eventType = "EventType"
        case turnType = "TurnType"
    }
}

extension HarshEventState {
    public var timestamp: Date? {
        return timestampString.flatMap { $0.dateFromIso8601 }
    }
}
