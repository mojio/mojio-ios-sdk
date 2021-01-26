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

public protocol MeasurementStatsModel: Codable {
    
    associatedtype S: ScoreModel
    
    var numOfSamples: Double { get }
    var average: Double { get }
    var variance: Double { get }
    var stdDev: Double { get }
    var indexOfDispersion: Double { get }
    var coeffOfVariation: Double { get }
    var m2: Double { get }
    var min: Double { get }
    var max: Double { get }
    var standardScore: S? { get }
    var minMaxScore: S? { get }
}

public struct MeasurementStats: MeasurementStatsModel {
    
    public typealias S = Score
    
    public let numOfSamples: Double
    public let average: Double
    public let variance: Double
    public let stdDev: Double
    public let indexOfDispersion: Double
    public let coeffOfVariation: Double
    public let m2: Double
    public let min: Double
    public let max: Double
    public let standardScore: S?
    public let minMaxScore: S?
    
    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case numOfSamples = "NumOfSamples"
        case average = "Average"
        case variance = "Variance"
        case stdDev = "StdDev"
        case indexOfDispersion = "IndexOfDispersion"
        case coeffOfVariation = "CoeffOfVariation"
        case m2 = "M2"
        case min = "Min"
        case max = "Max"
        case standardScore = "StandardScore"
        case minMaxScore = "MinMaxScore"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
                
            self.numOfSamples = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.numOfSamples) ?? 0
            self.average = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.average) ?? 0
            self.variance = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.variance) ?? 0
            self.stdDev = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.stdDev) ?? 0
            self.indexOfDispersion = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.indexOfDispersion) ?? 0
            self.coeffOfVariation = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.coeffOfVariation) ?? 0
            self.m2 = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.m2) ?? 0
            self.min = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.min) ?? 0
            self.max = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.max) ?? 0
            self.standardScore = try container.decodeIfPresentIgnoringCase(Score.self, forKey: CodingKeys.standardScore)
            self.minMaxScore = try container.decodeIfPresentIgnoringCase(Score.self, forKey: CodingKeys.minMaxScore)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.numOfSamples, forKey: .numOfSamples)
        try container.encodeIfPresent(self.average, forKey: .average)
        try container.encodeIfPresent(self.variance, forKey: .variance)
        try container.encodeIfPresent(self.stdDev, forKey: .stdDev)
        
        try container.encodeIfPresent(self.indexOfDispersion, forKey: .indexOfDispersion)
        try container.encodeIfPresent(self.coeffOfVariation, forKey: .coeffOfVariation)
        try container.encodeIfPresent(self.m2, forKey: .m2)
        try container.encodeIfPresent(self.min, forKey: .min)
        
        try container.encodeIfPresent(self.max, forKey: .max)
        try container.encodeIfPresent(self.standardScore, forKey: .standardScore)
        try container.encodeIfPresent(self.minMaxScore, forKey: .minMaxScore)
    }
}
