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

import UIKit
import ObjectMapper

public enum ScoreMethods: String {
    case zScore = "ZScore"
    case minMaxScore = "MinMaxScore"
}

public struct Score: Mappable {
    
    // ScoreMethods
    public var ScoringMethod: String? = nil
    public var Value: Double = 0
    public var Percentile: Double = 0
    public var Average: Double = 0
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }

    public mutating func mapping(map: Map) {
        ScoringMethod <- map["ScoringMethod"]
        Value <- map["Value"]
        Percentile <- map["Percentile"]
        Average <- map["Average"]
    }

}
