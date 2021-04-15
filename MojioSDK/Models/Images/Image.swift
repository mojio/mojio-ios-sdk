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
import Alamofire
import MojioCore

public protocol ImageModel: Codable {
    var id: String { get }
    var ownerId: String? { get }
    var url: URL? { get }
    var mimeType: MimeType.Image? { get }
    var deleted: Bool? { get }
}

public struct Image: ImageModel {
    public let id: String
    public let ownerId: String?
    public let url: URL?
    public let mimeType: MimeType.Image?
    public let deleted: Bool?
    
    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case id = "Id"
        case ownerId = "OwnerId"
        case url = "Url"
        case mimeType = "ContentType"
        case deleted = "Deleted"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        do {
            self.id = try container.decodeIgnoringCase(String.self, forKey: CodingKeys.id)
            self.ownerId = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.ownerId)
            self.url = try container.decodeIfPresentIgnoringCase(URL.self, forKey: CodingKeys.url)
            self.mimeType = try container.decodeIfPresentIgnoringCase(MimeType.Image.self, forKey: CodingKeys.mimeType)
            self.deleted = try container.decodeIfPresentIgnoringCase(Bool.self, forKey: CodingKeys.deleted)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}
