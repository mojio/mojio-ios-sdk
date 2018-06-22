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

public protocol DisplayDetailsModel: Codable {
    var showOnMap: Bool? { get }
    var color: EntityAppearanceColor? { get }
    var icon: String? { get }
    var profileImage: String? { get }
}

public struct DisplayDetails: DisplayDetailsModel {
    public let showOnMap: Bool?
    public let color: EntityAppearanceColor?
    public let icon: String?
    public let profileImage: String?

    public enum CodingKeys: String, CodingKey {
        case showOnMap = "ShowOnMap"
        case color = "Color"
        case icon = "Icon"
        case profileImage = "ProfileImage"
    }
}

public struct DisplayDetailsUpdate: Codable {
    public var showOnMap: Bool?
    public var color: EntityAppearanceColor?
    public var icon: String?
    public var profileImage: String?

    public enum CodingKeys: String, CodingKey {
        case showOnMap = "ShowOnMap"
        case color = "Color"
        case icon = "Icon"
        case profileImage = "ProfileImage"
    }

    public init(from displayDetailsModel: DisplayDetailsModel? = nil) {
        self.init(
            showOnMap: displayDetailsModel?.showOnMap,
            color: displayDetailsModel?.color,
            icon: displayDetailsModel?.icon,
            profileImage: displayDetailsModel?.profileImage
        )
    }

    public init(
        showOnMap: Bool? = nil,
        color: EntityAppearanceColor? = nil,
        icon: String? = nil,
        profileImage: String? = nil) {

        self.showOnMap = showOnMap
        self.color = color
        self.icon = icon
        self.profileImage = profileImage
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(self.showOnMap, forKey: .showOnMap)
        try container.encodeIfPresent(self.color, forKey: .color)
        try container.encodeIfPresent(self.icon, forKey: .icon)
        try container.encodeIfPresent(self.profileImage, forKey: .profileImage)
    }
}
