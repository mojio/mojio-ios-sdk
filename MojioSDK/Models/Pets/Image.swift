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
import Alamofire

public struct MimeType {
    public enum Image: String, Codable {
        case jpeg = "image/jpeg"
        case png = "image/png"
        case gif = "image/gif"
        case bmp = "image/bmp"
    }
    
    public enum Application: String, Codable {
        case json = "application/json"
    }
}

public struct Image: Codable {
    public let id: String
    public let ownerId: String?
    public let url: URL?
    public let mimeType: MimeType.Image?
    public let deleted: Bool?
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case ownerId = "OwnerId"
        case url = "Url"
        case mimeType = "ContentType"
        case deleted = "Deleted"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.id = try container.decode(String.self, forKey: .id)
            self.ownerId = try container.decodeIfPresent(String.self, forKey: .ownerId)
            self.url = try container.decodeIfPresent(URL.self, forKey: .url)
            self.mimeType = try container.decodeIfPresent(MimeType.Image.self, forKey: .mimeType)
            self.deleted = try container.decodeIfPresent(Bool.self, forKey: .deleted)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

