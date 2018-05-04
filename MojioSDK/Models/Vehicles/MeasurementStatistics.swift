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

public struct MeasurementStatistics: Codable {
    
    public let numOfSamples: Double
    public let average: Double
    public let variance: Double
    public let stdDev: Double
    public let indexOfDispersion: Double
    public let coeffOfVariation: Double
    public let m2: Double
    public let min: Double
    public let max: Double
    public let standardScore: Score?
    public let minMaxScore: Score?
    
    public enum CodingKeys: String, CodingKey {
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
}
