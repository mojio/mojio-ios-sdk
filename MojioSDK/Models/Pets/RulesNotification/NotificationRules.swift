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

public enum RulesType: String, Codable {
    case unknown = "Unknown"
    case separation = "Separation"
    case movement = "Movement"
    case disturbance = "Disturbance"
    case offline = "Offline"
    case chargedBattery = "ChargedBattery"
    case devicePaired = "DevicePaired"
    case lightOff = "LightOff"
    case highTemperatureNotification = "HighTemperatureNotification"
    case lowTemperatureNotification = "LowTemperatureNotification"
    case lowBattery = "LowBattery"
    
    public var description: String {
        switch self {
            
        case .separation:
            return "Separation"
        case .movement:
            return "Movement"
        case .disturbance:
            return "Disturbance"
        case .offline:
            return "Offline"
        case .chargedBattery:
            return "Charged Battery"
        case .devicePaired:
            return "Device Paired"
        case .lightOff:
            return "Light Off"
        case .highTemperatureNotification:
            return "High Temperature Notification"
        case .lowTemperatureNotification:
            return "Low Temperature Notification"
        case .lowBattery:
            return "Low Battery"
        default:
            return "Unknown"
            
        }
    }
}

public protocol NotificationRulesModel: Codable {
    
    associatedtype W: ActiveTimeWindowModel
    
    var separation: W? { get }
    var movement: W? { get }
    var disturbance: W? { get }
    var offline: W? { get }
    var chargedBattery: W? { get }
    var devicePaired: W? { get }
    var lightOff: W? { get }
    var highTemperatureNotification: W? { get }
    var lowTemperatureNotification: W? { get }
    var lowBattery: W? { get }
}

public struct NotificationRules: NotificationRulesModel {

    public typealias W = ActiveTimeWindow
    
    public var separation: W?
    public var movement: W?
    public var disturbance: W?
    public var offline: W?
    public var chargedBattery: W?
    public var devicePaired: W?
    public var lightOff: W?
    public var highTemperatureNotification: W?
    public var lowTemperatureNotification: W?
    public var lowBattery: W?
    
    public lazy var arrNotificationRules: [W?] = {
        return [movement,disturbance,offline,lowBattery]
    }()
    
    public enum CodingKeys: String, CodingKey {
        case separation = "Separation"
        case movement = "Movement"
        case disturbance = "Disturbance"
        case offline = "Offline"
        case chargedBattery = "ChargedBattery"
        case devicePaired = "DevicePaired"
        case lightOff = "LightOff"
        case highTemperatureNotification = "HighTemperatureNotification"
        case lowTemperatureNotification = "LowTemperatureNotification"
        case lowBattery = "LowBattery"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.separation = try container.decodeIfPresent(ActiveTimeWindow.self, forKey: .separation)
            self.movement = try container.decodeIfPresent(ActiveTimeWindow.self, forKey: .movement)
            self.disturbance = try container.decodeIfPresent(ActiveTimeWindow.self, forKey: .disturbance)
            self.offline = try container.decodeIfPresent(ActiveTimeWindow.self, forKey: .offline)
            self.chargedBattery = try container.decodeIfPresent(ActiveTimeWindow.self, forKey: .chargedBattery)
            self.devicePaired = try container.decodeIfPresent(ActiveTimeWindow.self, forKey: .devicePaired)
            self.lightOff = try container.decodeIfPresent(ActiveTimeWindow.self, forKey: .lightOff)
            self.highTemperatureNotification = try container.decodeIfPresent(ActiveTimeWindow.self, forKey: .highTemperatureNotification)
            self.lowTemperatureNotification = try container.decodeIfPresent(ActiveTimeWindow.self, forKey: .lowTemperatureNotification)
            self.lowBattery = try container.decodeIfPresent(ActiveTimeWindow.self, forKey: .lowBattery)
            
            self.separation?.rulesType = .separation
            self.movement?.rulesType = .movement
            self.disturbance?.rulesType = .disturbance
            self.offline?.rulesType = .offline
            self.chargedBattery?.rulesType = .chargedBattery
            self.devicePaired?.rulesType = .devicePaired
            self.lightOff?.rulesType = .lightOff
            self.highTemperatureNotification?.rulesType = .highTemperatureNotification
            self.lowTemperatureNotification?.rulesType = .lowTemperatureNotification
            self.lowBattery?.rulesType = .lowBattery
        }
        catch {
            debugPrint(error)
            throw error
        }
    }

    public mutating func getRulesArray(assetType: AssetType = .asset) // -> [W?]
    {
        switch assetType
        {
        case .people, .pet:
            arrNotificationRules = [offline,lowBattery]  //According to Call with Adam - 21-08-2019
        case .asset,.bike, .vehicle, .other, .unknown:
            arrNotificationRules = [movement,disturbance,offline,lowBattery]  //According to Call with Adam - 21-08-2019
        }
        
        //All Rules Type
        //[separation,movement,disturbance,offline,chargedBattery,devicePaired,lightOff,highTemperatureNotification, lowTemperatureNotification,lowBattery]
    }
}

public struct NotificationRulesUpdate: Codable {

    public typealias W = ActiveTimeWindowUpdate
    
    public var separation: W?
    public var movement: W?
    public var disturbance: W?
    public var offline: W?
    public var chargedBattery: W?
    public var devicePaired: W?
    public var lightOff: W?
    public var highTemperatureNotification: W?
    public var lowTemperatureNotification: W?
    public var lowBattery: W?
    
    public lazy var arrNotificationRules: [W?] = {
        return [movement,disturbance,offline,lowBattery]
    }()
    
    public enum CodingKeys: String, CodingKey {
        case separation = "Separation"
        case movement = "Movement"
        case disturbance = "Disturbance"
        case offline = "Offline"
        case chargedBattery = "ChargedBattery"
        case devicePaired = "DevicePaired"
        case lightOff = "LightOff"
        case highTemperatureNotification = "HighTemperatureNotification"
        case lowTemperatureNotification = "LowTemperatureNotification"
        case lowBattery = "LowBattery"
    }
    
    public init(model: NotificationRules? = nil) {
        self.init(
            
            separation: ActiveTimeWindowUpdate(model: model?.separation),
            movement: ActiveTimeWindowUpdate(model: model?.movement),
            disturbance: ActiveTimeWindowUpdate(model: model?.disturbance),
            offline: ActiveTimeWindowUpdate(model: model?.offline),
            chargedBattery: ActiveTimeWindowUpdate(model: model?.chargedBattery),
            devicePaired: ActiveTimeWindowUpdate(model: model?.devicePaired),
            lightOff: ActiveTimeWindowUpdate(model: model?.lightOff),
            highTemperatureNotification: ActiveTimeWindowUpdate(model: model?.highTemperatureNotification),
            lowTemperatureNotification: ActiveTimeWindowUpdate(model: model?.lowTemperatureNotification),
            lowBattery: ActiveTimeWindowUpdate(model: model?.lowBattery)
        )
    }
    
    public init(
        separation: ActiveTimeWindowUpdate? = nil,
        movement: ActiveTimeWindowUpdate? = nil,
        disturbance: ActiveTimeWindowUpdate? = nil,
        offline: ActiveTimeWindowUpdate? = nil,
        chargedBattery: ActiveTimeWindowUpdate? = nil,
        devicePaired: ActiveTimeWindowUpdate? = nil,
        lightOff: ActiveTimeWindowUpdate? = nil,
        highTemperatureNotification: ActiveTimeWindowUpdate? = nil,
        lowTemperatureNotification: ActiveTimeWindowUpdate? = nil,
        lowBattery: ActiveTimeWindowUpdate? = nil) {
        
        self.separation = separation
        self.movement = movement
        self.disturbance = disturbance
        self.offline = offline
        self.chargedBattery = chargedBattery
        self.devicePaired = devicePaired
        self.lightOff = lightOff
        self.highTemperatureNotification = highTemperatureNotification
        self.lowTemperatureNotification = lowTemperatureNotification
        self.lowBattery = lowBattery
        
        self.separation?.rulesType = .separation
        self.movement?.rulesType = .movement
        self.disturbance?.rulesType = .disturbance
        self.offline?.rulesType = .offline
        self.chargedBattery?.rulesType = .chargedBattery
        self.devicePaired?.rulesType = .devicePaired
        self.lightOff?.rulesType = .lightOff
        self.highTemperatureNotification?.rulesType = .highTemperatureNotification
        self.lowTemperatureNotification?.rulesType = .lowTemperatureNotification
        self.lowBattery?.rulesType = .lowBattery
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.separation, forKey: .separation)
        try container.encodeIfPresent(self.movement, forKey: .movement)
        try container.encodeIfPresent(self.disturbance, forKey: .disturbance)
        try container.encodeIfPresent(self.offline, forKey: .offline)
        try container.encodeIfPresent(self.chargedBattery, forKey: .chargedBattery)
        try container.encodeIfPresent(self.devicePaired, forKey: .devicePaired)
        try container.encodeIfPresent(self.lightOff, forKey: .lightOff)
        try container.encodeIfPresent(self.highTemperatureNotification, forKey: .highTemperatureNotification)
        try container.encodeIfPresent(self.lowTemperatureNotification, forKey: .lowTemperatureNotification)
        try container.encodeIfPresent(self.lowBattery, forKey: .lowBattery)
    }
    
    public mutating func getRulesArray(assetType: AssetType? = .asset) // -> [W?]
    {
        switch assetType
        {
        case .people?, .pet?:
            arrNotificationRules = [offline,lowBattery]  //According to Call with Adam - 21-08-2019
        case .asset?,.bike?, .vehicle?, .other?, .unknown?:
            arrNotificationRules = [movement,disturbance,offline,lowBattery]  //According to Call with Adam - 21-08-2019 with Adam - 21-08-2019
        case .none:
            arrNotificationRules = [movement,disturbance,offline,lowBattery]  //According to Call with Adam - 21-08-2019
        }
        
        //All Rules Type
        //[separation,movement,disturbance,offline,chargedBattery,devicePaired,lightOff,highTemperatureNotification, lowTemperatureNotification,lowBattery]
    }
}
