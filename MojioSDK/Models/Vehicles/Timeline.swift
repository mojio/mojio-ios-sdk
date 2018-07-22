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

struct Timeline {
    enum TimelineActivityType: String, Codable {
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
    
    struct ActivityResult: Codable {
        
        let id: String?
        let type: ActivityType?
        let duration: String?
        let polyline: String?
        let tags: Array<String>?
        
        enum CodingKeys: String, CodingKey {
            case id
            case type
            case duration
            case polyline
            case tags
        }
    }
    
    struct RootActivity: Codable {
        
        typealias L = ActivityLocation
        typealias A = Activity
        typealias R = ActivityResult

        let id: String
        let type: ActivityType?
        let timelineType: TimelineActivityType?
        let name: String?
        
        let actor: A?
        let origin: L?
        let target: L?
        let location: L?
        let result: R?

        let startTime: Date?
        let published: Date?

        enum CodingKeys: String, CodingKey {
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

