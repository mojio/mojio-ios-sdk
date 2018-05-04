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

public enum HeadingUnit: String {
    case degree = "Degree"
}

public struct Heading: DeviceMeasurement {
    
    // DeviceMeasurement
    public let baseUnit: String?
    public let baseValue: Double
    public let unit: String?
    public let value: Double
    public let timestamp: Date?
    
    public let direction: String?
    public let leftTurn: Bool

    public enum CodingKeys: String, CodingKey {
        case direction = "Direction"
        case leftTurn = "LeftTurn"
    }
}

extension Heading {

    public var baseHeadingUnit: HeadingUnit? {
        
        if let unit = self.baseUnit {
            return HeadingUnit(rawValue: unit)
        }
        
        return nil
    }
    
    public var headingUnit: HeadingUnit? {
        
        if let unit = self.unit {
            return HeadingUnit(rawValue: unit)
        }
        
        return nil
    }
}

extension Heading  {
    
    public init(from decoder: Decoder, with deviceMeasurements: DeviceMeasurements) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let direction = try container.decodeIfPresent(String.self, forKey: .direction)
        
        let leftTurn = try container.decodeIfPresent(Bool.self, forKey: .leftTurn) ?? false
        
        self.init(
            baseUnit: deviceMeasurements.baseUnit,
            baseValue: deviceMeasurements.baseValue,
            unit: deviceMeasurements.unit,
            value: deviceMeasurements.value,
            timestamp: deviceMeasurements.timestamp,
            direction: direction,
            leftTurn: leftTurn)
    }
    
    public func encode(with encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.direction, forKey: .direction)
        try container.encode(self.leftTurn, forKey: .leftTurn)
    }
}
