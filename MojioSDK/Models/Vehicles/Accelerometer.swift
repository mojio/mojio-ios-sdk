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

//import UIKit

public struct Accelerometer: Codable {
    
    public var X: ProperAcceleration? = nil
    public var Y: ProperAcceleration? = nil
    public var Z: ProperAcceleration? = nil
    public var Magnitude: ProperAcceleration? = nil
    public var SamplingInterval: TimePeriod? = nil
}

//    public init?(map: Map) {
//        self.init()
//    }
//
//    public mutating func mapping(map: Map) {
//        X <- map["X"]
//        Y <- map["Y"]
//        Z <- map["Z"]
//        Magnitude <- map["Magnitude"]
//        SamplingInterval <- map["SamplingInterval"]
//    }
