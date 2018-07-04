//
//  HarshEventState.swift
//  MojioSDK
//
//  Created by Suresh Venkatraman on 6/26/17.
//  Copyright © 2017 Mojio. All rights reserved.
//

import Foundation

public enum HarshEventType: String, Codable {
    
    case acceleration = "Acceleration"
    case deceleration = "Deceleration"
    case turning = "Turning"
    case upward = "Upward"
    case downward = "Downward"
    case accident = "Accident"
    case postAccident = "PostAccident"
    
    case unknown = "Unknown"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = HarshEventType(rawValue: label) ?? .unknown
    }
}

public enum HarshEventTurnType: String, Codable {
    
    case left = "Left"
    case right = "Right"
    
    case unknown = "Unknown"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = HarshEventTurnType(rawValue: label) ?? .unknown
    }
}

public protocol HarshEventStateModel: Codable {
    var timestamp: Date? { get }
    var value: Bool { get }
    var eventType: HarshEventType? { get }
    var turnType: HarshEventTurnType? { get }
}

public struct HarshEventState: HarshEventStateModel {
    
    public let timestamp: Date?
    public let value: Bool
    public let eventType: HarshEventType?
    public let turnType: HarshEventTurnType?
    
    public enum CodingKeys: String, CodingKey {
        case timestamp = "Timestamp"
        case value = "Value"
        case eventType = "EventType"
        case turnType = "TurnType"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.timestamp = try container.decodeIfPresent(String.self, forKey: .timestamp).flatMap { $0.dateFromISO }
            self.value = try container.decodeIfPresent(Bool.self, forKey: .value) ?? false
            self.eventType = try container.decodeIfPresent(HarshEventType.self, forKey: .eventType)
            self.turnType = try container.decodeIfPresent(HarshEventTurnType.self, forKey: .turnType)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.timestamp, forKey: .timestamp)
        try container.encodeIfPresent(self.value, forKey: .value)
        try container.encodeIfPresent(self.eventType, forKey: .eventType)
        try container.encodeIfPresent(self.turnType, forKey: .turnType)
    }
}
