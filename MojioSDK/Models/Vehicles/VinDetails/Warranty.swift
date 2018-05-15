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

public protocol GeneralWarranty {
    var name: String? { get }
    var type: String? { get }
    var months: String? { get }
    var km: Double? { get }
}

public struct Warranty: Codable, GeneralWarranty {
    
    public let name: String?
    public let type: String?
    public let months: String?
    public let km: Double?
    
    public enum CodingKeys: String, CodingKey {
        case name = "Name"
        case type = "Type"
        case months = "Months"
        case km = "Km"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.type = try container.decodeIfPresent(String.self, forKey: .type)
            self.months = try container.decodeIfPresent(String.self, forKey: .months)
            self.km = try container.decodeIfPresent(Double.self, forKey: .km)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
