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

public enum VehicleCompatibilityLevel: String, Codable {
    case full = "Full"
    case partial = "Partial"
    case minimum = "Minimum"
    case notCompatible = "NotCompatible"
    case unknown = "Unknown"
}

public struct CompatibilityDetails: Codable {
    
    public let level: String?
    public let changed: Bool
    public let lastChecked: String?
    
    private enum CodingKeys: String, CodingKey {
        case level = "Level"
        case changed = "Changed"
        case lastChecked = "LastChecked"
    }
}