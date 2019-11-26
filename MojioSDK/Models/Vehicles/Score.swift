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

public enum ScoreMethods: String, Codable {
    
    case zScore = "ZScore"
    case minMaxScore = "MinMaxScore"
    
    case unknown
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = ScoreMethods(rawValue: label) ?? .unknown
    }
}

public protocol ScoreModel: Codable {
    var scoringMethod: ScoreMethods? { get }
    var value: Double { get }
    var percentile: Double { get }
    var average: Double { get }
}

public struct Score: ScoreModel {
    
    // ScoreMethods
    public let scoringMethod: ScoreMethods?
    public let value: Double
    public let percentile: Double
    public let average: Double
    
    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case scoringMethod = "ScoringMethod"
        case value = "Value"
        case percentile = "Percentile"
        case average = "Average"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            
            self.scoringMethod = try container.decodeIfPresentIgnoringCase(ScoreMethods.self, forKey: CodingKeys.scoringMethod)
            self.value = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.value) ?? 0
            self.percentile = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.percentile) ?? 0
            self.average = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.average) ?? 0
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.scoringMethod, forKey: .scoringMethod)
        try container.encodeIfPresent(self.value, forKey: .value)
        try container.encodeIfPresent(self.percentile, forKey: .percentile)
        try container.encodeIfPresent(self.average, forKey: .average)
    }
}
