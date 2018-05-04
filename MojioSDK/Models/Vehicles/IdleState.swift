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

public struct IdleState: Codable {
    
    public var timestamp: Date? = nil
    public var value: Bool = false
    public var startTime: String? = nil
    public var duration: TimePeriod? = nil
    
    public enum CodingKeys: String, CodingKey {
        case timestamp = "Timestamp"
        case value = "Value"
        case startTime = "StartTime"
        case duration = "Duration"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.timestamp = try container.decodeIfPresent(String.self, forKey: .timestamp).flatMap { $0.dateFromIso8601 }
            self.value = try container.decodeIfPresent(Bool.self, forKey: .value) ?? false
            self.startTime = try container.decodeIfPresent(String.self, forKey: .startTime)
            self.duration = try container.decodeIfPresent(TimePeriod.self, forKey: .duration)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
