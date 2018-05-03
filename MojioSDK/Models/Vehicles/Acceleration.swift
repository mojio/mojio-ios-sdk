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

// Units are in AccelerationUnits
public struct Acceleration: DeviceMeasurement {

    // DeviceMeasurement
    public var baseUnit: String? = nil
    public var baseValue: Double = 0
    public var unit: String? = nil
    public var value: Double = 0
    public var timestamp: Date?  = nil
}

extension Acceleration {
    
    public init(from decoder: Decoder, with deviceMeasurements: DeviceMeasurements) throws {
        
        self.init(baseUnit: deviceMeasurements.baseUnit, baseValue: deviceMeasurements.baseValue, unit: deviceMeasurements.unit, value: deviceMeasurements.value, timestamp: deviceMeasurements.timestamp)
    }
    
    public func encode(with encoder: Encoder) throws {
    
    }
}
