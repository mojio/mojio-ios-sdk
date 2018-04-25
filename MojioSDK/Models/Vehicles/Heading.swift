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
import Foundation

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
    
    //public var timeStamp: Date? = nil
    
    public var Direction: String? = nil
    public var LeftTurn: Bool = false

    private enum CodingKeys: String, CodingKey {
        case Direction
        case LeftTurn
    }
}

extension Heading {

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
}

extension Heading  {
    
    public init(from decoder: Decoder, with deviceMeasurements: DeviceMeasurements) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let Direction = try container.decodeIfPresent(String.self, forKey: .Direction)
        
        let LeftTurn = try container.decodeIfPresent(Bool.self, forKey: .LeftTurn) ?? false
        
        self.init(BaseUnit: deviceMeasurements.BaseUnit, BaseValue: deviceMeasurements.BaseValue, Unit: deviceMeasurements.Unit, Value: deviceMeasurements.Value, Timestamp: deviceMeasurements.Timestamp, Direction: Direction, LeftTurn: LeftTurn)
    }
    
    public func encode(with encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.Direction, forKey: .Direction)
        try container.encode(self.LeftTurn, forKey: .LeftTurn)
    }
}

//public init() {}

//public init?(map: Map) {
//    self.init()
//}
//
//public mutating func mapping(map: Map) {
//    self.measureMapping(map: map)
//
//    Direction <- map["Direction"]
//    LeftTurn <- map["LeftTurn"]
//}
