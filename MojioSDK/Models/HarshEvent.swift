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

import UIKit
import ObjectMapper

public enum HarshEventEventType: String {
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

public struct HarshEvent: Mappable {
    
    public var Timestamp: String? = nil
    public var Value: Bool = false
    public var EventType: String? = nil
    public var TurnType: String? = nil
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }

    public mutating func mapping(map: Map) {
        Timestamp <- map["Timestamp"]
        Value <- map["Value"]
        EventType <- map["EventType"]
        TurnType <- map["TurnType"]
    }
    
}
