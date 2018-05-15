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
    
    public enum CodingKeys: String, CodingKey {
        case x = "X"
        case y = "Y"
        case z = "Z"
        case magnitude = "Magnitude"
        case samplingInterval = "SamplingInterval"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.x = try container.decodeIfPresent(ProperAcceleration.self, forKey: .x)
            self.y = try container.decodeIfPresent(ProperAcceleration.self, forKey: .y)
            self.z = try container.decodeIfPresent(ProperAcceleration.self, forKey: .z)
            self.magnitude = try container.decodeIfPresent(ProperAcceleration.self, forKey: .magnitude)
            self.samplingInterval = try container.decodeIfPresent(TimePeriod.self, forKey: .samplingInterval)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        //MARK: - TO DO/TO CHECK
    }
}
