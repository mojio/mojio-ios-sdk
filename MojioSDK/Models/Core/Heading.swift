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

//Heading
public enum HeadingUnit: String, Codable {
    case degree = "Degree"
    case unknown = "Unknown"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = HeadingUnit(rawValue: label) ?? .unknown
    }
}

public protocol HeadingModel: DeviceMeasurement {
    var direction: String? { get }
    var leftTurn: Bool { get }
}

public struct Heading: HeadingModel {
    
    public typealias U = HeadingUnit
    
    // DeviceMeasurement
    public let baseUnit: U
    public let baseValue: Double
    public let unit: U
    public let value: Double
    public let timestamp: Date?
    
    public let direction: String?
    public let leftTurn: Bool

    public enum CodingKeys: String, CodingKey {
        case direction = "Direction"
        case leftTurn = "LeftTurn"
    }
}

public extension Heading  {
    
    public init(from decoder: Decoder, with deviceMeasurements: DeviceMeasurements) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let direction = try container.decodeIfPresent(String.self, forKey: .direction)
        
        let leftTurn = try container.decodeIfPresent(Bool.self, forKey: .leftTurn) ?? false
        
        self.init(
            baseUnit: deviceMeasurements.baseUnit ?? .unknown,
            baseValue: deviceMeasurements.baseValue,
            unit: deviceMeasurements.unit ?? .unknown,
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
