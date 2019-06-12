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
}

public struct Buzzer: BuzzerModel {
    public let enabled: Bool?
    public let type: BuzzerType?
    
    public enum CodingKeys: String, CodingKey {
        case enabled = "Enabled"
        case type = "Type"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
            self.type = try container.decodeIfPresent(BuzzerType.self, forKey: .type)
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
    
    public enum CodingKeys: String, CodingKey {
        case enabled = "Enabled"
        case type = "Type"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.enabled, forKey: .enabled)
        try container.encodeIfPresent(self.type, forKey: .type)
    }
    
    public init(enabled: Bool? = nil, type: BuzzerType? = nil) {
        
        self.enabled = enabled
        self.type = type
    }
}
