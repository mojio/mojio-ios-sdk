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

public protocol GeneralImage {
    var source: URL? { get }
    var normal: URL? { get }
    var thumbnail: URL? { get }
}

public struct Image: Codable, GeneralImage  {
    public let source: URL?
    public let normal: URL?
    public let thumbnail: URL?
    
    public enum CodingKeys: String, CodingKey {
        case source = "Src"
        case normal = "Normal"
        case thumbnail = "Thumbnail"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.source = try container.decodeIfPresent(URL.self, forKey: .source)
            self.normal = try container.decodeIfPresent(URL.self, forKey: .normal)
            self.thumbnail = try container.decodeIfPresent(URL.self, forKey: .thumbnail)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
