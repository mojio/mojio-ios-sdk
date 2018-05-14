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

public protocol GeneralEngine {
    var name: String? { get }
    var cylinders: String? { get }
    var displacement: Double { get }
    var fuelInduction: String? { get }
    var fuelQuality: String? { get }
    var fuelType: String? { get }
    var maxHp: String? { get }
    var maxHpAt: String? { get }
}

public struct Engine: Codable, GeneralEngine {
    
    public let name: String?
    public let cylinders: String?
    public let displacement: Double
    public let fuelInduction: String?
    public let fuelQuality: String?
    public let fuelType: String?
    public let maxHp: String?
    public let maxHpAt: String?
    
    public enum CodingKeys: String, CodingKey {
        case name = "Name"
        case cylinders = "Cylinders"
        case displacement = "Displacement"
        case fuelInduction = "FuelInduction"
        case fuelQuality = "FuelQuality"
        case fuelType = "FuelType"
        case maxHp = "MaxHp"
        case maxHpAt = "MaxHpAt"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.cylinders = try container.decodeIfPresent(String.self, forKey: .cylinders)
            self.displacement = try container.decodeIfPresent(Double.self, forKey: .displacement) ?? 0
            self.fuelInduction = try container.decodeIfPresent(String.self, forKey: .fuelInduction)
            self.fuelQuality = try container.decodeIfPresent(String.self, forKey: .fuelQuality)
            self.fuelType = try container.decodeIfPresent(String.self, forKey: .fuelType)
            self.maxHp = try container.decodeIfPresent(String.self, forKey: .maxHp)
            self.maxHpAt = try container.decodeIfPresent(String.self, forKey: .maxHpAt)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
