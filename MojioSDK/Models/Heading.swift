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

public enum HeadingUnit: String {
    case degree = "Degree"
}

public struct Heading: DeviceMeasurement {
    
    // DeviceMeasurement
    public var BaseUnit: String? = nil
    public var BaseValue: Double = 0
    public var Unit: String? = nil
    public var Value: Double = 0
    public var Timestamp: String?  = nil
    
    public var Direction: String? = nil
    public var LeftTurn: Bool = false

    public var baseHeadingUnit: HeadingUnit? {
        if let unit = self.BaseUnit {
            return HeadingUnit(rawValue: unit)
        }
        
        return nil
    }
    
    public var headingUnit: HeadingUnit? {
        if let unit = self.Unit {
            return HeadingUnit(rawValue: unit)
        }
        
        return nil
    }
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }

    public mutating func mapping(map: Map) {
        Direction <- map["Direction"]
        LeftTurn <- map["LeftTurn"]
        Timestamp <- map["Timestamp"]

        BaseUnit <- map["BaseUnit"]
        BaseValue <- map["BaseValue"]

        Unit <- map["Unit"]
        Value <- map["Value"]
    }
}
