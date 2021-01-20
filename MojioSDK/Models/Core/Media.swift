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

public protocol VehicleMediaType: Codable {
    var id: String { get }
    var tenantId: String { get }
    var mojioId: String { get }
    var vehicleId: String { get }
    var mediaType: MediaType { get }
    var source: MediaSourceType { get }
    var thumbnailUrl: String? { get }
    var url: String? { get }
}

public struct ApiMedia: VehicleMediaType {
    
    public let id: String
    public let tenantId: String
    public let mojioId: String
    public let vehicleId: String
    public let mediaType: MediaType
    public let source: MediaSourceType
    public let thumbnailUrl: String?
    public let url: String?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case tenantId
        case mojioId
        case vehicleId
        case mediaType
        case source
        case thumbnailUrl
        case url
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.id = try container.decode(String.self, forKey: .id)
            self.tenantId = try container.decode(String.self, forKey: .tenantId)
            self.mojioId = try container.decode(String.self, forKey: .mojioId)
            self.vehicleId = try container.decode(String.self, forKey: .vehicleId)
            self.mediaType = try container.decode(MediaType.self, forKey: .mediaType)
            self.source = try container.decode(MediaSourceType.self, forKey: .source)
            self.thumbnailUrl = try container.decodeIfPresent(String.self, forKey: .thumbnailUrl)
            self.url = try container.decodeIfPresent(String.self, forKey: .url)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode (to encoder: Encoder) throws {
        var container = encoder.container (keyedBy: CodingKeys.self)
        try container.encode (self.id, forKey: .id)
        try container.encode (self.tenantId, forKey: .tenantId)
        try container.encode (self.mojioId, forKey: .mojioId)
        try container.encode (self.vehicleId, forKey: .vehicleId)
        try container.encode (self.mediaType, forKey: .mediaType)
        try container.encode (self.source, forKey: .source)
        try container.encode (self.thumbnailUrl, forKey: .thumbnailUrl)
        try container.encode (self.url, forKey: .url)
    }
}

public enum MediaSourceType: String, Codable {
    case front = "Front"
    case rear = "Rear"
    case none = "None"
}

public enum MediaType: String, Codable {
    case video = "Video"
    case image = "Image"
    case none = "None"
}
