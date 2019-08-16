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
    var color: EntityAppearanceColor? { get }
}

public struct GenericAssetDetails: GenericAssetDetailsModel {
    
    public let color: EntityAppearanceColor?
    
    public enum CodingKeys: String, CodingKey {
        case color = "Color"
    }
}

public struct GenericAssetDetailsUpdate: Codable {
    
    public var color: EntityAppearanceColor?
    
    public enum CodingKeys: String, CodingKey {
        case color = "Color"
    }
    public init(from genericAssetDetailsModel: GenericAssetDetailsModel? = nil) {
        self.init(
            color: genericAssetDetailsModel?.color
        )
    }
    
    public init(color: EntityAppearanceColor? = nil) {
        self.color = color
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.color, forKey: .color)
    }
}
