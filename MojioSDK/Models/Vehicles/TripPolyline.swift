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

public protocol TripPolylineModel: Codable, PrimaryKey {
    var id: String { get }
    var polyline: String? { get }
    var createdOn: Date? { get }
    var lastModified: Date? { get }
    var deleted: Bool { get }
}

public struct Polyline: TripPolylineModel {
    
    public let id: String
    public let polyline: String?
    public let createdOn: Date?
    public let lastModified: Date?
    public let deleted: Bool
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case polyline = "Polyline"
        case createdOn = "CreatedOn"
        case lastModified = "LastModified"
        case deleted = "Deleted"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.id = try container.decode(String.self, forKey: .id)
            self.polyline = try container.decodeIfPresent(String.self, forKey: .polyline)
            self.createdOn = try container.decodeIfPresent(String.self, forKey: .createdOn).flatMap { $0.dateFromIso8601 }
            self.lastModified = try container.decodeIfPresent(String.self, forKey: .lastModified).flatMap { $0.dateFromIso8601 }
            self.deleted = try container.decodeIfPresent(Bool.self, forKey: .deleted) ?? false
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
