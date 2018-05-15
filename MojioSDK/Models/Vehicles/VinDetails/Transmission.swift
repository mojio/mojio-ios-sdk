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

public protocol TransmissionModel: Codable {
    var name: String? { get }
    var type: String? { get }
    var detailType: String? { get }
    var gears: String? { get }
}

public struct Transmission: TransmissionModel {
    
    public let name: String?
    public let type: String?
    public let detailType: String?
    public let gears: String?
    
    public enum CodingKeys: String, CodingKey {
        case name = "Name"
        case type = "Type"
        case detailType = "DetailType"
        case gears = "Gears"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.type = try container.decodeIfPresent(String.self, forKey: .type)
            self.detailType = try container.decodeIfPresent(String.self, forKey: .detailType)
            self.gears = try container.decodeIfPresent(String.self, forKey: .gears)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
