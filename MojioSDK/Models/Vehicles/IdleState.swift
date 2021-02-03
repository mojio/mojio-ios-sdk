/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2021 Copyright Moj.io Inc.
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

public protocol IdleStateModel: Codable {
    
    associatedtype T: TimePeriodModel
    
    var timestamp: Date? { get }
    var value: Bool { get }
    var startTime: String? { get }
    var duration: T? { get }
}

public struct IdleState: IdleStateModel {
    
    public typealias T = TimePeriod
    
    public var timestamp: Date? = nil
    public var value: Bool = false
    public var startTime: String? = nil
    public var duration: T? = nil
    
    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case timestamp = "Timestamp"
        case value = "Value"
        case startTime = "StartTime"
        case duration = "Duration"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            
            self.timestamp = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.timestamp).flatMap { $0.dateFromISO }
            self.value = try container.decodeIfPresentIgnoringCase(Bool.self, forKey: CodingKeys.value) ?? false
            self.startTime = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.startTime)
            self.duration = try container.decodeIfPresentIgnoringCase(TimePeriod.self, forKey: CodingKeys.duration)
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
        try container.encodeIfPresent(self.startTime, forKey: .startTime)
        try container.encodeIfPresent(self.duration, forKey: .duration)
    }
}
