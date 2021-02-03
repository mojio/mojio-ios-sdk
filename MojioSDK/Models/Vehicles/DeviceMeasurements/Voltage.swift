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

public protocol VoltageModel: DeviceMeasurement {
    
    associatedtype T: TimePeriodModel
}

public struct Voltage: VoltageModel {
    
    public typealias T = TimePeriod
    public typealias U = BatteryVoltageUnit
    
    //DeviceMeasurement
    public let baseUnit: U
    public let baseValue: Double
    public let unit: U
    public let value: Double
    public let timestamp: Date?
}

extension Voltage {
    
    public init(from decoder: Decoder, with deviceMeasurements: DeviceMeasurements) throws {
        
        self.init(baseUnit: deviceMeasurements.baseUnit ?? .unknown, baseValue: deviceMeasurements.baseValue, unit: deviceMeasurements.unit ?? .unknown, value: deviceMeasurements.value, timestamp: deviceMeasurements.timestamp)
    }

    public func encode(with encoder: Encoder) throws {

        try self.encode(to: encoder)
    }
}

