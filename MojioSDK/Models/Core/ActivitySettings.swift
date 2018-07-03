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

public protocol ActivitySettingsContainerModel: Codable {
    associatedtype S = ActivitySettingsNotificationModel
    
    var lowBattery: S? { get }
}

public protocol ActivitySettingsNotificationModel: Codable {
    var enabled: Bool { get }
    var sound: String? { get }
}

public struct ActivitySettingsContainer: ActivitySettingsContainerModel {
    public typealias S = ActivitySettingsNotification
    
    public var lowBattery: S?
    
    enum CodingKeys: String, CodingKey {
        case lowBattery = "LowBattery"
    }
}

public struct ActivitySettingsNotification: ActivitySettingsNotificationModel {
    public var enabled: Bool
    public var sound: String?
    
    enum CodingKeys: String, CodingKey {
        case enabled = "Enabled"
        case sound = "Sound"
    }
}

// TODO: Add ActivitySettingsUpdate for update flow
