/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2021 Copyright Moj.io Inc.
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

public protocol AccelerometerModel: Codable {
    
    associatedtype A: ProperAccelerationModel
    associatedtype T: TimePeriodModel
    
    var x: A? { get }
    var y: A? { get }
    var z: A? { get }
    var magnitude: A? { get }
    var samplingInterval: T? { get }
}

public struct Accelerometer: AccelerometerModel {
    
    public typealias A = ProperAcceleration
    public typealias T = TimePeriod

    public var x: A? = nil
    public var y: A? = nil
    public var z: A? = nil
    public var magnitude: A? = nil
    public var samplingInterval: T? = nil
    
    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case x = "X"
        case y = "Y"
        case z = "Z"
        case magnitude = "Magnitude"
        case samplingInterval = "SamplingInterval"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            
            self.x = try container.decodeIfPresentIgnoringCase(ProperAcceleration.self, forKey: CodingKeys.x)
            self.y = try container.decodeIfPresentIgnoringCase(ProperAcceleration.self, forKey: CodingKeys.y)
            self.z = try container.decodeIfPresentIgnoringCase(ProperAcceleration.self, forKey: CodingKeys.z)
            self.magnitude = try container.decodeIfPresentIgnoringCase(ProperAcceleration.self, forKey: CodingKeys.magnitude)
            self.samplingInterval = try container.decodeIfPresentIgnoringCase(TimePeriod.self, forKey: CodingKeys.samplingInterval)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.x, forKey: .x)
        try container.encodeIfPresent(self.y, forKey: .y)
        try container.encodeIfPresent(self.z, forKey: .z)
        try container.encodeIfPresent(self.magnitude, forKey: .magnitude)
        try container.encodeIfPresent(self.samplingInterval, forKey: .samplingInterval)
    }
}
