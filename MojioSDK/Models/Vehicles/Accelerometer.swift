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

public struct Accelerometer: Codable {
    
    public var x: ProperAcceleration? = nil
    public var y: ProperAcceleration? = nil
    public var z: ProperAcceleration? = nil
    public var magnitude: ProperAcceleration? = nil
    public var samplingInterval: TimePeriod? = nil
    
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
