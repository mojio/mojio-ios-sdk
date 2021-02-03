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

public protocol ServiceScheduleModel: Codable {
    
    associatedtype S: ServiceScheduleItemModel
    
    var vin: String? { get }
    var isDefault: Bool? { get }
    var items: [S] { get }
}

public struct ServiceSchedule: ServiceScheduleModel {
    
    public typealias S = ServiceScheduleItem
    
    public var vin: String? = nil
    public var isDefault: Bool? = nil
    public var items: [S] = []
    
    public enum CodingKeys: String, CodingKey {
        case vin = "VIN"
        case isDefault = "IsDefault"
        case items = "Items"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.vin = try container.decodeIfPresent(String.self, forKey: .vin)
            self.isDefault = try container.decodeIfPresent(Bool.self, forKey: .isDefault) ?? false
            
            self.items = try container.decodeIfPresent([ServiceScheduleItem].self, forKey: .items) ?? []
            
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.vin, forKey: .vin)
        try container.encodeIfPresent(self.isDefault, forKey: .isDefault)
        try container.encodeIfPresent(self.items, forKey: .items)
    }
}
