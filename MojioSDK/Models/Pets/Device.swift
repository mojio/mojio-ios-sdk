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

public enum PowerStatus: String, Codable {
    case unknown = "Unknown"
    case sleep = "Sleep"
    case powerOff = "PowerOff"
    case normal = "Normal"
}

public protocol DeviceModel: Codable, PrimaryKey {
    
    associatedtype PL: PetsLocationModel
    associatedtype T: DeviceTypeModel
    associatedtype B: BatteryModel
    associatedtype TA: TemperatureAlarmModel
    associatedtype L: LightModel
    
    var imei: String { get }
    var deviceId: String { get }
    var name: String? { get }
    var assetId: String? { get }
    var location: PL? { get }
    var speed: Double? { get }
    var airplaneMode: Bool? { get }
    var deviceType: T? { get }
    var powerStatus: PowerStatus? { get }
    var battery: B? { get }
    var temperature: Double? { get }
    var highTemperatureAlarm: TA? { get }
    var lowTemperatureAlarm: TA? { get }
    var light: L? { get }
    var online: Bool? { get }
    var msisdn: String? { get }
    var firmwareVersion: String? { get }
    var color: String? { get }
    var tenantId: String? { get }
    var ownerId: String? { get }
    var createdOn: Date? { get }
    var deleted: Bool? { get }
    var lastModified: Date? { get }
    var gatewayTime: Date? { get }
}

public struct Device: DeviceModel {
    
    public typealias PL = PetsLocation
    public typealias T = DeviceType
    public typealias B = Battery
    public typealias TA = TemperatureAlarm
    public typealias L = Light
    
    public let imei: String
    public let deviceId: String
    public let name: String?
    public let assetId: String?
    public let location: PL?
    public let speed: Double?
    public let airplaneMode: Bool?
    public let deviceType: T?
    public let powerStatus: PowerStatus?
    public let battery: B?
    public let temperature: Double?
    public let highTemperatureAlarm: TA?
    public let lowTemperatureAlarm: TA?
    public let light: L?
    public let online: Bool?
    public let msisdn: String?
    public let firmwareVersion: String?
    public let manufacturer: String?
    public let color: String?
    public let tenantId: String?
    public let ownerId: String?
    public let createdOn: Date?
    public let deleted: Bool?
    public let lastModified: Date?
    public let gatewayTime: Date?
    
    public var id: String {
        return self.deviceId
    }
    
    public enum CodingKeys: String, CodingKey {
        case imei = "IMEI"
        case deviceId = "DeviceId"
        case name = "Name"
        case assetId = "AssetId"
        case location = "Location"
        case speed = "Speed"
        case airplaneMode = "AirplaneMode"
        case deviceType = "DeviceType"
        case powerStatus = "PowerStatus"
        case battery = "Battery"
        case temperature = "Temperature"
        case highTemperatureAlarm = "HighTemperatureAlarm"
        case lowTemperatureAlarm = "LowTemperatureAlarm"
        case light = "Light"
        case online = "Online"
        case msisdn = "MSISDN"
        case firmwareVersion = "FirmwareVersion"
        case manufacturer = "Manufacturer"
        case color = "Color"
        case tenantId = "TenantId"
        case ownerId = "OwnerId"
        case createdOn = "CreatedOn"
        case deleted = "Deleted"
        case lastModified = "LastModified"
        case gatewayTime = "GatewayTime"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.imei = try container.decode(String.self, forKey: .imei)
            self.deviceId = try container.decode(String.self, forKey: .deviceId)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.assetId = try container.decodeIfPresent(String.self, forKey: .assetId)
            self.location = try container.decodeIfPresent(PetsLocation.self, forKey: .location)
            self.speed = try container.decodeIfPresent(Double.self, forKey: .speed)
            self.airplaneMode = try container.decodeIfPresent(Bool.self, forKey: .airplaneMode)
            self.deviceType = try container.decodeIfPresent(DeviceType.self, forKey: .deviceType)
            self.powerStatus = try container.decodeIfPresent(PowerStatus.self, forKey: .powerStatus)
            self.battery = try container.decodeIfPresent(Battery.self, forKey: .battery)
            self.temperature = try container.decodeIfPresent(Double.self, forKey: .temperature)
            self.highTemperatureAlarm = try container.decodeIfPresent(TemperatureAlarm.self, forKey: .highTemperatureAlarm)
            self.lowTemperatureAlarm = try container.decodeIfPresent(TemperatureAlarm.self, forKey: .lowTemperatureAlarm)
            self.light = try container.decodeIfPresent(Light.self, forKey: .light)
            self.online = try container.decodeIfPresent(Bool.self, forKey: .online)
            self.msisdn = try container.decodeIfPresent(String.self, forKey: .msisdn)
            self.firmwareVersion = try container.decodeIfPresent(String.self, forKey: .firmwareVersion)
            self.manufacturer = try container.decodeIfPresent(String.self, forKey: .manufacturer)
            self.color = try container.decodeIfPresent(String.self, forKey: .color)
            self.tenantId = try container.decodeIfPresent(String.self, forKey: .tenantId)
            self.ownerId = try container.decodeIfPresent(String.self, forKey: .ownerId)
            self.createdOn = try container.decodeIfPresent(String.self, forKey: .createdOn).flatMap { $0.dateFromISO }
            self.deleted = try container.decodeIfPresent(Bool.self, forKey: .deleted)
            self.lastModified = try container.decodeIfPresent(String.self, forKey: .lastModified).flatMap { $0.dateFromISO }
            self.gatewayTime = try container.decodeIfPresent(String.self, forKey: .gatewayTime).flatMap { $0.dateFromISO }
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

public struct DeviceUpdate: Codable {
    public var name: String? = nil
    public var light: LightUpdate? = nil
    public var highTemperatureAlarm: TemperatureAlarmUpdate? = nil
    public var lowTemperatureAlarm: TemperatureAlarmUpdate? = nil
    
    public enum CodingKeys: String, CodingKey {
        case name = "Name"
        case light = "Light"
        case highTemperatureAlarm = "HighTemperatureAlarm"
        case lowTemperatureAlarm = "LowTemperatureAlarm"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.light, forKey: .light)
        try container.encodeIfPresent(self.highTemperatureAlarm, forKey: .highTemperatureAlarm)
        try container.encodeIfPresent(self.lowTemperatureAlarm, forKey: .lowTemperatureAlarm)
    }
    
    public init(name: String? = nil, light: LightUpdate? = nil, highTemperatureAlarm: TemperatureAlarmUpdate? = nil, lowTemperatureAlarm: TemperatureAlarmUpdate? = nil) {
        self.name = name
        self.light = light
        self.highTemperatureAlarm = highTemperatureAlarm
        self.lowTemperatureAlarm = lowTemperatureAlarm
    }
}
