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
import MojioCore

public struct Distance: DeviceMeasurement {
    
    // DeviceMeasurement
    public let baseUnit: String?
    public let baseValue: Double
    public let unit: String?
    public let value: Double
    public let timestamp: Date?
    
//    public func jsonDict() -> [String:Any] {
//        var map: [String:Any] = [:]
//        
//        if let baseUnit = self.baseUnit {
//            map["baseUnit"] = baseUnit as AnyObject?
//            map["baseValue"] = self.baseValue as AnyObject?
//        }
//        
//        if let unit = self.unit {
//            map["Unit"] = unit as AnyObject?
//            map["Value"] = self.value as AnyObject?
//        }
//
//        return map
//    }
}

extension Distance {
    
    public init(from decoder: Decoder, with deviceMeasurements: DeviceMeasurements) throws {
        
        self.init(baseUnit: deviceMeasurements.baseUnit, baseValue: deviceMeasurements.baseValue, unit: deviceMeasurements.unit, value: deviceMeasurements.value, timestamp: deviceMeasurements.timestamp)
    }
    
    public func encode(with encoder: Encoder) throws {
        
    }
}
