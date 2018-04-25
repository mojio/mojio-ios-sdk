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

// Units are in PercentageUnits
public struct FuelLevel: DeviceMeasurement {
    
    // DeviceMeasurement
    public var BaseUnit: String? = nil
    public var BaseValue: Double = 0
    public var Unit: String? = nil
    public var Value: Double = 0
    public var Timestamp: String?  = nil
    
    //public var timeStamp: Date? = nil
    
    public var RiskSeverity: String? = nil
    
    private enum CodingKeys: String, CodingKey {
        case RiskSeverity
    }
}

extension FuelLevel {
    
    public init(from decoder: Decoder, with deviceMeasurements: DeviceMeasurements) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let RiskSeverity = try container.decodeIfPresent(String.self, forKey: .RiskSeverity)
        
        self.init(BaseUnit: deviceMeasurements.BaseUnit, BaseValue: deviceMeasurements.BaseValue, Unit: deviceMeasurements.Unit, Value: deviceMeasurements.Value, Timestamp: deviceMeasurements.Timestamp, RiskSeverity: RiskSeverity)
    }
    
    public func encode(with encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.RiskSeverity, forKey: .RiskSeverity)
    }
}

//public init() {}
//
//public init?(map: Map) {
//    self.init()
//}
//
//public mutating func mapping(map: Map) {
//    self.measureMapping(map: map)
//
//    RiskSeverity <- map["RiskSeverity"]
//}
