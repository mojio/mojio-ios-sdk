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

public enum LightType: String, Codable {
    case solid = "Solid"
    case breathing = "Breathing"
    case blinking = "Blinking"
}
public enum ColorType: String, Codable {
    case red = "Red"
    case greed = "Greed"
    case blue = "Blue"
}

public protocol LightModel: Codable {
    var enabled: Bool? { get }
    var type: LightType? { get }
    var color: ColorType? { get }
    var durationInSeconds: Int? { get }
}

public struct Light: LightModel {
    public let enabled: Bool?
    public let type: LightType?
    public let color: ColorType?
    public let durationInSeconds: Int?
    
    public enum CodingKeys: String, CodingKey {
        case enabled = "Enabled"
        case type = "Type"
        case color = "Color"
        case durationInSeconds = "DurationInSeconds"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
            self.type = try container.decodeIfPresent(LightType.self, forKey: .type)
            self.color = try container.decodeIfPresent(ColorType.self, forKey: .color)
            self.durationInSeconds = try container.decodeIfPresent(Int.self, forKey: .durationInSeconds)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

public struct LightUpdate: Codable {
    public var enabled: Bool?
    public var type: LightType?
    public var color: ColorType?
    public var durationInSeconds: Int?
    
    public enum CodingKeys: String, CodingKey {
        case enabled = "Enabled"
        case type = "Type"
        case color = "Color"
        case durationInSeconds = "DurationInSeconds"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.enabled, forKey: .enabled)
        try container.encodeIfPresent(self.type, forKey: .type)
        try container.encodeIfPresent(self.color, forKey: .color)
        try container.encodeIfPresent(self.durationInSeconds, forKey: .durationInSeconds)
    }
    
    public init(enabled: Bool? = nil, type: LightType? = nil, color: ColorType? = nil, durationInSeconds: Int? = nil) {
        
        self.enabled = enabled
        self.type = type
        self.color = color
        self.durationInSeconds = durationInSeconds
    }
}
