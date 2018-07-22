/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2017 Copyright Moj.io Inc.
 * All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains, the property of
 * Moj.io Inc. and its suppliers, if any.  The intellectual and technical
 * concepts contained herein are proprietary to Moj.io Inc. and its suppliers
 * and may be covered by Patents, pending patents, and are protected by trade
 * secret or copyright law.
 *
 * Dissemination of this information or reproduction of this material is strictly
 * forbidden unless prior written permission is obtained from Moj.io Inc.
 *******************************************************************************/

import Foundation
import MojioCore

public struct Timeline {
    public enum TimelineActivityType: String, Codable {
        case tripCompleted = "TripCompleted"
        case tripStarted = "TripStarted"
        case enteredGeofence = "EnteredGeofence"
        case exitedGeofence = "ExitedGeofence"
        case deviceUnplugged = "DeviceUnplugged"
        case newVehicleConnected = "NewVehicleConnected"
        case recallNotice = "RecallNotice"
        case lowFuel = "LowFuel"
        case dtcDetected = "DTCDetected"
        case lowBattery = "LowBattery"
        case exceededSpeedLimit = "ExceededSpeedLimit"
        case tow = "Tow"
        case disturbance = "Disturbance"
        case milStatus = "MILStatus"
        case accident = "Accident"
        case serviceMessage = "Service Message"
    }
    
    public struct ActivityResult: Codable {
        
        public let id: String?
        public let type: ActivityType?
        public let duration: String?
        public let polyline: String?
        public let tags: Array<String>?
        
        public enum CodingKeys: String, CodingKey {
            case id
            case type
            case duration
            case polyline
            case tags
        }
    }
    
    public struct RootActivity: Codable {
        
        public typealias L = ActivityLocation
        public typealias A = Activity
        public typealias R = ActivityResult

        public let id: String
        public let type: ActivityType?
        public let timelineType: TimelineActivityType?
        public let name: String?
        
        public let actor: A?
        public let origin: L?
        public let target: L?
        public let location: L?
        public let result: R?

        public let startTime: Date?
        public let published: Date?

        public enum CodingKeys: String, CodingKey {
            case id
            case type
            case timelineType
            case name
            case startTime
            case published
            case target
            case result
            case origin
            case actor
            case location
        }
    }
}

