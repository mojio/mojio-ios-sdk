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

// Units are in AccelerationUnits
public struct Acceleration: DeviceMeasurement {

    // DeviceMeasurement
    public var BaseUnit: String? = nil
    public var BaseValue: Double = 0
    public var Unit: String? = nil
    public var Value: Double = 0
    public var Timestamp: String?  = nil
    
    //public var timeStamp: Date? = nil
}

extension Acceleration {
    
    public init(from decoder: Decoder, with deviceMeasurements: DeviceMeasurements) throws {
        
        self.init(BaseUnit: deviceMeasurements.BaseUnit, BaseValue: deviceMeasurements.BaseValue, Unit: deviceMeasurements.Unit, Value: deviceMeasurements.Value, Timestamp: deviceMeasurements.Timestamp)
    }
    
    public func encode(with encoder: Encoder) throws {
    
    }
}

//public init() {}

//    public init?(map: Map) {
//        self.init()
//    }
