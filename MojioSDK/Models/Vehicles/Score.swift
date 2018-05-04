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

public enum ScoreMethods: String {
    case zScore = "ZScore"
    case minMaxScore = "MinMaxScore"
}

public struct Score: Codable {
    
    // ScoreMethods
    public let scoringMethod: String?
    public let value: Double
    public let percentile: Double
    public let average: Double
    
    public enum CodingKeys: String, CodingKey {
        case scoringMethod = "ScoringMethod"
        case value = "Value"
        case percentile = "Percentile"
        case average = "Average"
    }
}
