/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2019 Copyright Moj.io Inc.
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

public enum BuzzerType: String, Codable {
    case single = "Single"
    case find = "Find"
}

public protocol BuzzerModel: Codable {
    var enabled: Bool? { get }
    var type: BuzzerType? { get }
    var durationInSeconds: Int? { get }
}

public struct Buzzer: BuzzerModel {
    public let enabled: Bool?
    public let type: BuzzerType?
    public let durationInSeconds: Int?
    
    public enum CodingKeys: String, CodingKey {
        case enabled = "Enabled"
        case type = "Type"
        case durationInSeconds = "DurationInSeconds"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
            self.type = try container.decodeIfPresent(BuzzerType.self, forKey: .type)
            self.durationInSeconds = try container.decodeIfPresent(Int.self, forKey: .durationInSeconds)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

public struct BuzzerUpdate: Codable {
    public var enabled: Bool?
    public var type: BuzzerType?
    public var durationInSeconds: Int?
    
    public enum CodingKeys: String, CodingKey {
        case enabled = "Enabled"
        case type = "Type"
        case durationInSeconds = "DurationInSeconds"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.enabled, forKey: .enabled)
        try container.encodeIfPresent(self.type, forKey: .type)
        try container.encodeIfPresent(self.durationInSeconds, forKey: .durationInSeconds)
    }
    
    public init(enabled: Bool? = nil, type: BuzzerType? = nil, durationInSeconds: Int? = nil) {
        
        self.enabled = enabled
        self.type = type
        self.durationInSeconds = durationInSeconds
    }
}
