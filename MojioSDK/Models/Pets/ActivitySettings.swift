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

public protocol ActivitySettingsModel: Codable {
    associatedtype N = NotificationSettingsModel
    
    var lowBattery: N { get }
    var offline: N { get }
}

public protocol NotificationSettingsModel: Codable {
    var enabled: Bool { get }
    var sound: String? { get }
}

public struct ActivitySettings: ActivitySettingsModel {
    public typealias N = NotificationSettings
    
    public var lowBattery: NotificationSettings
    public var offline: NotificationSettings
    public var highTemperature: NotificationSettings
    public var lowTemperature: NotificationSettings
    
    enum CodingKeys: String, CodingKey {
        case lowBattery = "LowBattery"
        case offline = "Offline"
        case highTemperature = "HighTemperature"
        case lowTemperature = "LowTemperature"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.lowBattery = try container.decode(NotificationSettings.self, forKey: .lowBattery)
            self.offline = try container.decode(NotificationSettings.self, forKey: .offline)
            self.highTemperature = try container.decode(NotificationSettings.self, forKey: .highTemperature)
            self.lowTemperature = try container.decode(NotificationSettings.self, forKey: .lowTemperature)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
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
