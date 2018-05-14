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

public protocol GeneralNextServiceSchedule {
    
    associatedtype P: GeneralPlatformServiceSchedule
    
    var timeStamp: String? { get }
    var odometer: Double { get }
    var ageInMonths: Int? { get }
    var timeUnits: String? { get }
    var timeValue: Double { get }
    var distanceUnits: String? { get }
    var distanceValue: Double { get }
    var services: [P] { get }
}

public struct NextServiceSchedule: Codable, GeneralNextServiceSchedule {
    
    public typealias P = PlatformServiceSchedule
    
    public var timeStamp: String? = nil
    public var odometer: Double = 0
    public var ageInMonths: Int? = nil
    public var timeUnits: String? = nil
    public var timeValue: Double = 0
    public var distanceUnits: String? = nil
    public var distanceValue: Double = 0
    public var services: [P] = []
    
    public enum CodingKeys: String, CodingKey {
        case timeStamp = "TimeStamp"
        case odometer = "Odometer"
        case ageInMonths = "AgeInMonths"
        case timeUnits = "TimeUnits"
        case timeValue = "TimeValue"
        case distanceUnits = "DistanceUnits"
        case distanceValue = "DistanceValue"
        case services = "Items"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.timeStamp = try container.decodeIfPresent(String.self, forKey: .timeStamp)
            self.odometer = try container.decodeIfPresent(Double.self, forKey: .odometer) ?? 0
            self.ageInMonths = try container.decodeIfPresent(Int.self, forKey: .ageInMonths) ?? 0
            self.timeUnits = try container.decodeIfPresent(String.self, forKey: .timeUnits)
            self.timeValue = try container.decodeIfPresent(Double.self, forKey: .timeValue) ?? 0
            self.distanceUnits = try container.decodeIfPresent(String.self, forKey: .distanceUnits)
            self.distanceValue = try container.decodeIfPresent(Double.self, forKey: .distanceValue) ?? 0
            self.services = try container.decodeIfPresent([PlatformServiceSchedule].self, forKey: .services) ?? []
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
