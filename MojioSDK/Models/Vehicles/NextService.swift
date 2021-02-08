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

public protocol NextServiceModel: Codable {
    
    var timestamp: Date? { get }
    var distanceToNextService: Distance? { get }
    var timeToNextService: TimePeriod? { get }
}

public struct NextService: NextServiceModel {
    
    public var timestamp: Date? = nil
    public var distanceToNextService: Distance? = nil
    public var timeToNextService: TimePeriod? = nil

    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case timestamp = "Timestamp"
        case distanceToNextService = "DistanceToNextService"
        case timeToNextService = "TimeToNextService"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            
            self.timestamp = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.timestamp).flatMap { $0.dateFromISO }
            self.distanceToNextService = try container.decodeIfPresentIgnoringCase(Distance.self, forKey: CodingKeys.distanceToNextService)
            self.timeToNextService = try container.decodeIfPresentIgnoringCase(TimePeriod.self, forKey: CodingKeys.timeToNextService)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.timestamp, forKey: .timestamp)
        try container.encodeIfPresent(self.distanceToNextService, forKey: .distanceToNextService)
        try container.encodeIfPresent(self.timeToNextService, forKey: .timeToNextService)
    }
}
