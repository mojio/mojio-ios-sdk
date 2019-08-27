/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2019 Copyright Moj.io Inc.
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

public protocol GenericAssetDetailsModel: Codable {
    var color: String? { get }
    var style: String? { get }
}

public struct GenericAssetDetails: GenericAssetDetailsModel {
    
    public let color: String?
    public let style: String?
    
    public enum CodingKeys: String, CodingKey {
        case color = "Color"
        case style = "Style"
    }
}

public struct GenericAssetDetailsUpdate: Codable {
    
    public var color: String? = nil
    public var style: String? = nil
    
    public enum CodingKeys: String, CodingKey {
        case color = "Color"
        case style = "Style"
    }
    public init(genericAssetDetailsModel: GenericAssetDetailsModel? = nil) {
        self.init(
            color: genericAssetDetailsModel?.color,
            style: genericAssetDetailsModel?.style
        )
    }
    
    public init(color: String? = nil, style: String? = nil) {
        self.color = color
        self.style = style
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.color, forKey: .color)
        try container.encodeIfPresent(self.style, forKey: .style)
    }
}