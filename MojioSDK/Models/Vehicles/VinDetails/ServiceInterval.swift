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

public protocol GeneralServiceInterval {
    var operatingParameter: String? { get }
    var operatingParameterNotes: String? { get }
    var intervalType: String? { get }
    var value: Double { get }
    var units: String? { get }
    var initialValue: Double { get }
}

public struct ServiceInterval: Codable, GeneralServiceInterval {
    
    public let operatingParameter: String?
    public let operatingParameterNotes: String?
    public let intervalType: String?
    public let value: Double
    public let units: String?
    public let initialValue: Double
    
    public enum CodingKeys: String, CodingKey {
        case operatingParameter = "OperatingParameter"
        case operatingParameterNotes = "OperatingParameterNotes"
        case intervalType = "IntervalType"
        case value = "Value"
        case units = "Units"
        case initialValue = "InitialValue"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.operatingParameter = try container.decodeIfPresent(String.self, forKey: .operatingParameter)
            self.operatingParameterNotes = try container.decodeIfPresent(String.self, forKey: .operatingParameterNotes)
            
            self.intervalType = try container.decodeIfPresent(String.self, forKey: .intervalType)
            self.value = try container.decodeIfPresent(Double.self, forKey: .value) ?? 0
            
            self.units = try container.decodeIfPresent(String.self, forKey: .units)
            self.initialValue = try container.decodeIfPresent(Double.self, forKey: .initialValue) ?? 0
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
