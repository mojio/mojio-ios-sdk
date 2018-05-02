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

// Units in DistanceUnits
public struct Odometer: DeviceMeasurement {
    
    // DeviceMeasurement
    public var baseUnit: String? = nil
    public var baseValue: Double = 0
    public var unit: String? = nil
    public var value: Double = 0
    public var timestamp: Date?  = nil
    
    //public var timeStamp: Date? = nil
    
    public var RolloverValue: Double = 0
    
//    public func jsonDict () -> [String: Any] {
//
//        var dictionary = [String: Any]()
//
//        if let unit = self.unit {
//            dictionary["Unit"] = unit
//        }
//
//        dictionary["Value"] = self.value
//
//        return dictionary
//    }
    
    private enum CodingKeys: String, CodingKey {
        case RolloverValue
    }
}

extension Odometer {
    
    public init(from decoder: Decoder, with deviceMeasurements: DeviceMeasurements) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let RolloverValue = try container.decodeIfPresent(Double.self, forKey: .RolloverValue) ?? 0.0
        
        self.init(baseUnit: deviceMeasurements.baseUnit, baseValue: deviceMeasurements.baseValue, unit: deviceMeasurements.unit, value: deviceMeasurements.value, timestamp: deviceMeasurements.timestamp, RolloverValue: RolloverValue)
    }
    
    public func encode(with encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.RolloverValue, forKey: .RolloverValue)
    }
}


//public init() {}
//
//public init?(map: Map) {
//    self.init()
//}
//public mutating func mapping(map: Map) {
//
//    self.measureMapping(map: map)
//
//    RolloverValue <- map["RolloverValue"]
//}
