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

public struct Device: Codable, PrimaryKey {
    public let imei: String
    public let deviceId: String
    public let name: String?
    public let assetId: String?
    public let location: PetsLocation?
    public let speed: Double?
    public let airplaneMode: Bool?
    public let deviceType: DeviceType?
    public let powerStatus: PowerStatus?
    public let battery: Battery?
    public let firmwareVersion: String?
    public let color: String?
    public let tenantId: String?
    public let ownerId: String?
    public let createdOn: Date?
    public let deleted: Bool?
    public let lastModified: Date?
    public let gatewayTime: Date?
    
    public var id: String {
        return self.imei
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
        case firmwareVersion = "FirmwareVersion"
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
            self.firmwareVersion = try container.decodeIfPresent(String.self, forKey: .firmwareVersion)
            self.color = try container.decodeIfPresent(String.self, forKey: .color)
            self.tenantId = try container.decodeIfPresent(String.self, forKey: .tenantId)
            self.ownerId = try container.decodeIfPresent(String.self, forKey: .ownerId)
            self.createdOn = try container.decodeIfPresent(String.self, forKey: .createdOn).flatMap { $0.dateFromIso8601 }
            self.deleted = try container.decodeIfPresent(Bool.self, forKey: .deleted)
            self.lastModified = try container.decodeIfPresent(String.self, forKey: .lastModified).flatMap { $0.dateFromIso8601 }
            self.gatewayTime = try container.decodeIfPresent(String.self, forKey: .gatewayTime).flatMap { $0.dateFromIso8601 }
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

public struct DeviceUpdate: Codable {
    public var name: String? = nil
    public var color: String? = nil
    
    public enum CodingKeys: String, CodingKey {
        case name = "Name"
        case color = "Color"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.color, forKey: .color)
    }
}
