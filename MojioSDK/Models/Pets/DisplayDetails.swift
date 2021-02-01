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
import MojioCore

public protocol DisplayDetailsModel: Codable {
    var profileImage: String? { get }
}

public struct DisplayDetails: DisplayDetailsModel {
    public let profileImage: String?

    public enum CodingKeys: String, CodingKey {
        case profileImage = "ProfileImage"
    }
}

public struct DisplayDetailsUpdate: Codable {
    public var profileImage: String?

    public enum CodingKeys: String, CodingKey {
        case profileImage = "ProfileImage"
    }

    public init(from displayDetailsModel: DisplayDetailsModel? = nil) {
        self.init(
            profileImage: displayDetailsModel?.profileImage
        )
    }

    public init(profileImage: String? = nil) {

        self.profileImage = profileImage
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(self.profileImage, forKey: .profileImage)
    }
}
