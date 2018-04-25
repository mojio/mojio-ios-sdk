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
import SwiftDate

// Base Device Measurement

fileprivate enum DeviceMeasurementCodingKeys: String, CodingKey {
    case BaseUnit
    case BaseValue
    case Unit
    case Value
    case Timestamp
}

public protocol DeviceMeasurement: Codable {
    
    typealias DeviceMeasurements = (BaseUnit: String?, BaseValue: Double, Unit: String?, Value: Double, Timestamp: String?)
    
    var BaseUnit: String? { get set }
    var BaseValue: Double  { get set }
    var Unit: String? { get set }
    var Value: Double { get set }
    var Timestamp: String? { get set }
    
    init(from decoder: Decoder, with deviceMeasurements: DeviceMeasurements) throws
    func encode(with encoder: Encoder) throws
    //var timeStamp: Date? {get set}
}

extension DeviceMeasurement {
    
    init(with decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: DeviceMeasurementCodingKeys.self)
        
        let BaseUnit = try container.decodeIfPresent(String.self, forKey: .BaseUnit)
        let BaseValue = try container.decodeIfPresent(Double.self, forKey: .BaseValue) ?? 0.0
        let Unit = try container.decodeIfPresent(String.self, forKey: .Unit)
        let Value = try container.decodeIfPresent(Double.self, forKey: .Value) ?? 0.0
        let Timestamp = try container.decodeIfPresent(String.self, forKey: .Timestamp)
        
        let deviceMeasurements = DeviceMeasurements(BaseUnit: BaseUnit, BaseValue: BaseValue, Unit: Unit, Value: Value, Timestamp: Timestamp)
        
        try self.init(from: decoder, with: deviceMeasurements)
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: DeviceMeasurementCodingKeys.self)
        
        try container.encode(self.BaseUnit, forKey: .BaseUnit)
        try container.encode(self.BaseValue, forKey: .BaseValue)
        try container.encode(self.Unit, forKey: .Unit)
        try container.encode(self.Value, forKey: .Value)
        try container.encode(self.Timestamp, forKey: .Timestamp)
        
        try self.encode(with: encoder)
    }
    
//    func getDeviceMeasurements(from decoder: Decoder) throws -> DeviceMeasurements {
//
//        let container = try decoder.container(keyedBy: DeviceMeasurementCodingKeys.self)
//
//        let BaseUnit = try container.decodeIfPresent(String.self, forKey: .baseUnit)
//        let BaseValue = try container.decodeIfPresent(Double.self, forKey: .baseValue) ?? 0.0
//        let Unit = try container.decodeIfPresent(String.self, forKey: .unit)
//        let Value = try container.decodeIfPresent(Double.self, forKey: .value) ?? 0.0
//        let Timestamp = try container.decodeIfPresent(String.self, forKey: .timestamp)
//
//        return DeviceMeasurements(BaseUnit: BaseUnit, BaseValue: BaseValue, Unit: Unit, Value: Value, Timestamp: Timestamp)
//    }
    
    var timeStamp: Date? {
        return self.Timestamp?.toDate
    }
}

//extension DeviceMeasurement {
//    public mutating func mapping(map: Map) {
//        self.measureMapping(map: map)
//    }
//
//    public mutating func measureMapping(map: Map) {
//        BaseUnit <- map["BaseUnit"]
//        BaseValue <- map["BaseValue"]
//        Unit <- map["Unit"]
//        Value <- map["Value"]
//        Timestamp <- map["Timestamp"]
//
//        timeStamp = self.Timestamp?.toDate
//    }
//}
