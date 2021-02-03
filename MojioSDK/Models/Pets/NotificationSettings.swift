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

public protocol NotificationSettingsModel: Codable {
    var enabled: Bool { get }
    var sound: String? { get }
}

public struct NotificationSettings: NotificationSettingsModel {
    public var enabled: Bool
    public var sound: String?
    public var threshold: Double?
    
    enum CodingKeys: String, CodingKey {
        case enabled = "Enabled"
        case sound = "Sound"
        case threshold = "Threshold"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.enabled = try container.decode(Bool.self, forKey: .enabled)
            self.sound = try container.decodeIfPresent(String.self, forKey: .sound)
            self.threshold = try container.decodeIfPresent(Double.self, forKey: .threshold)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

// TODO: Add ActivitySettingsUpdate for update flow
public struct NotificationSettingsUpdate: NotificationSettingsModel {
    public var enabled: Bool
    public var sound: String?
    public var threshold: Double?
    
    enum CodingKeys: String, CodingKey {
        case enabled = "Enabled"
        case sound = "Sound"
        case threshold = "Threshold"
    }
    
    public init(sound: String, isEnabled: Bool, threshold: Double? = nil) {
        self.enabled = isEnabled
        self.sound = sound
        self.threshold = threshold
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.enabled, forKey: .enabled)
        try container.encodeIfPresent(self.sound, forKey: .sound)
        try container.encodeIfPresent(self.threshold, forKey: .threshold)
    }
}
