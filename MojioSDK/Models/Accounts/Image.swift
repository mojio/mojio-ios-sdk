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

import ObjectMapper
import Foundation

public class Image: Mappable {
    public var source: URL? = nil
    public var normal: URL? = nil
    public var thumbnail: URL? = nil
    
    enum CodingKeys: String, CodingKey {
        case source = "Src"
        case normal = "Normal"
        case thumbnail = "Thumbnail"
    }
    
    public required init?(map: Map) {
        mapping(map: map)
    }
    
    public func mapping(map: Map) {
        source <- (map[CodingKeys.source], URLTransform())
        normal <- (map[CodingKeys.normal], URLTransform())
        thumbnail <- (map[CodingKeys.thumbnail], URLTransform())
    }
}
