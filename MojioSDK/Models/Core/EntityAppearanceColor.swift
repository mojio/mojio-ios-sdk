/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2020 Copyright Moj.io Inc.
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

public enum EntityAppearanceColor: String, Codable {
    
    case `default` = "Default"
    case graphite = "Graphite"
    case rust = "Rust"
    case orange = "Orange"
    case yellow = "Yellow"
    case cyan = "Cyan"
    case green = "Green"
    case blue = "Blue"
    case navy = "Navy"
    case purple = "Purple"
    case tan = "Tan"
    case brown = "Brown"
    case unplugged = "Unplugged"
    case red = "Red"
    case lightBlue = "Light blue"
    case darkBlue = "Dark blue"

    public init(from decoder: Decoder) throws {
        do {
            let value = try decoder.singleValueContainer().decode(String.self)
            self = EntityAppearanceColor.init(rawValue: value) ?? .default
        } catch {
            self = .default
        }
    }
}