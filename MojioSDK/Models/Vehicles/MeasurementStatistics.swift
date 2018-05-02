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
    
    public var NumOfSamples: Double = 0
    public var Average: Double = 0
    public var Variance: Double = 0
    public var StdDev: Double = 0
    public var IndexOfDispersion: Double = 0
    public var CoeffOfVariation: Double = 0
    public var M2: Double = 0
    public var Min: Double = 0
    public var Max: Double = 0
    public var StandardScore: Score? = nil
    public var MinMaxScore: Score? = nil
}

//public init() {}

//public init?(map: Map) {
//    self.init()
//}
//
//public mutating func mapping(map: Map) {
//    NumOfSamples <- map["NumOfSamples"]
//    Average <- map["Average"]
//    Variance <- map["Variance"]
//    StdDev <- map["StdDev"]
//    IndexOfDispersion <- map["IndexOfDispersion"]
//    CoeffOfVariation <- map["CoeffOfVariation"]
//    M2 <- map["M2"]
//    Min <- map["Min"]
//    Max <- map["Max"]
//    StandardScore <- map["StandardScore"]
//    MinMaxScore <- map["MinMaxScore"]
//}
