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

public enum NotificationMediaType: String, Codable {
    case text = "Text"
    case push = "Push"
    case email = "Email"

    public var description: String {
        switch self {
        case .text:
            return "Text"
        case .push:
            return "Push"
        case .email:
            return "Email"
        }
    }
    public static var all: [NotificationMediaType]
    {
        return [.text, .push, .email]
        
        /*switch appConfig.appType
        {
        case .Movistar:
            return [.push, .email]
        case .O2:
            return [.text, .push, .email]
        }*/
    }
}
public enum ActiveDaysOfWeek: String, Codable {
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case sunday = "Sunday"
    
    public var description: String {
        switch self {
        case .monday:
            return "Monday"
        case .tuesday:
            return "Tuesday"
        case .wednesday:
            return "Wednesday"
        case .thursday:
            return "Thursday"
        case .friday:
            return "Friday"
        case .saturday:
            return "Saturday"
        case .sunday:
            return "Sunday"
        }
    }
    public static var all: [ActiveDaysOfWeek]
    {
        return [.monday,.tuesday,.wednesday,.thursday,.friday,.saturday,.sunday]
    }
}

public protocol ActiveTimeWindowModel: Codable {
    
    associatedtype W: WeekDaysModel
    
    var activeTimeWindow: W? { get }
    var activeDaysOfWeek: [ActiveDaysOfWeek]? { get }
    var enabled: Bool? { get }
    var sound: String? { get }
    var notificationMedia: NotificationMediaType? { get }
    
}

public struct ActiveTimeWindow: ActiveTimeWindowModel {
    public typealias W = WeekDays
    
    public let activeTimeWindow: W?
    public let activeDaysOfWeek: [ActiveDaysOfWeek]?
    public let enabled: Bool?
    public let sound: String?
    public let notificationMedia: NotificationMediaType?
    
    public var rulesType: RulesType?
    
    public enum CodingKeys: String, CodingKey {
        
        case activeTimeWindow = "ActiveTimeWindow"
        case activeDaysOfWeek = "ActiveDaysOfWeek"
        case enabled = "Enabled"
        case sound = "Sound"
        case notificationMedia = "NotificationMedia"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.activeTimeWindow = try container.decodeIfPresent(WeekDays.self, forKey: .activeTimeWindow)
            self.activeDaysOfWeek = try container.decodeIfPresent([ActiveDaysOfWeek].self, forKey: .activeDaysOfWeek)
            self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
            self.sound = try container.decodeIfPresent(String.self, forKey: .sound)
            self.notificationMedia = try container.decodeIfPresent(NotificationMediaType.self, forKey: .notificationMedia)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}
public struct ActiveTimeWindowUpdate: Codable {

    public var activeTimeWindow: WeekDaysUpdate?
    public var activeDaysOfWeek: [ActiveDaysOfWeek]?
    public var enabled: Bool?
    public var sound: String?
    public var notificationMedia: NotificationMediaType?
    
    public var rulesType: RulesType?
    
    public enum CodingKeys: String, CodingKey {
        
        case activeTimeWindow = "ActiveTimeWindow"
        case activeDaysOfWeek = "ActiveDaysOfWeek"
        case enabled = "Enabled"
        case sound = "Sound"
        case notificationMedia = "NotificationMedia"
    }
    
    public init(model: ActiveTimeWindow? = nil) {
        self.init(
            activeTimeWindow: WeekDaysUpdate(model: model?.activeTimeWindow),
            activeDaysOfWeek: model?.activeDaysOfWeek,
            enabled: model?.enabled,
            sound: model?.sound,
            notificationMedia: model?.notificationMedia,
            rulesType: model?.rulesType
        )
    }
    public init(
        activeTimeWindow: WeekDaysUpdate? = nil,
        activeDaysOfWeek: [ActiveDaysOfWeek]? = nil,
        enabled: Bool? = nil,
        sound: String? = nil,
        notificationMedia: NotificationMediaType? = nil,
        rulesType: RulesType? = nil) {

        self.activeTimeWindow = activeTimeWindow
        self.activeDaysOfWeek = activeDaysOfWeek
        self.enabled = enabled
        self.sound = sound
        self.notificationMedia = notificationMedia
        
        self.rulesType = rulesType
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.activeTimeWindow, forKey: .activeTimeWindow)
        try container.encodeIfPresent(self.activeDaysOfWeek, forKey: .activeDaysOfWeek)
        try container.encodeIfPresent(self.enabled, forKey: .enabled)
        try container.encodeIfPresent(self.sound, forKey: .sound)
        try container.encodeIfPresent(self.notificationMedia, forKey: .notificationMedia)
    }
}

