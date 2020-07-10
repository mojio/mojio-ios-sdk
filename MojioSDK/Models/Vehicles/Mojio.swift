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

public protocol MojioModel: Codable, PrimaryKey {
    
    associatedtype L: LocationModel
    associatedtype W: WifiRadioModel
    associatedtype B: BooleanStateModel
    
    var id: String { get }
    var name: String? { get }
    var imei: String? { get }
    var lastContactTime: Date? { get }
    var gatewayTime: Date? { get }
    var vehicleId: String? { get }
    var location: L? { get }
    var tags: [String] { get }
    var wifi: W? { get }
    var connectedState: B? { get }
    var createdOn: Date? { get }
    var lastModified: Date? { get }
    var deleted: Bool { get }
    var msisdn: String? { get }
    var vendor: String? { get }
    var mainFirmware: String? { get }
    var firmwareVersion: String? { get }
    var hardwareVersion: String? { get }
    var iccid: String? { get }
}

public struct Mojio: MojioModel {
    
    public typealias L = Location
    
    public typealias W = WifiRadio
    
    public typealias B = BooleanState
    
    public let id: String
    public let name: String?
    public let imei: String?
    public let lastContactTime: Date?
    public let gatewayTime: Date?
    public let vehicleId: String?
    public let location: L?
    public let tags: [String]
    public let wifi: W?
    public let connectedState: B?
    public let createdOn: Date?
    public let lastModified: Date?
    public let deleted: Bool
    public let msisdn: String?
    public let vendor: String?
    public let mainFirmware: String?
    public let firmwareVersion: String?
    public let hardwareVersion: String?
    public let iccid: String?
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case imei = "IMEI"
        case lastContactTime = "LastContactTime"
        case wifi = "WifiRadio"
        case gatewayTime = "GatewayTime"
        case vehicleId = "VehicleId"
        case location = "Location"
        case connectedState = "ConnectedState"
        case createdOn = "CreatedOn"
        case lastModified = "LastModified"
        case tags = "Tags"
        case deleted = "Deleted"
        case msisdn = "MSISDN"
        case vendor = "Vendor"
        case mainFirmware = "MainFirmware"
        case firmwareVersion = "FirmwareVersion"
        case hardwareVersion = "HardwareVersion"
        case iccid = "ICCID"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIgnoringCase(String.self, forKey: .id)
        self.name = try container.decodeIfPresentIgnoringCase(String.self, forKey: .name)
        self.imei = try container.decodeIfPresentIgnoringCase(String.self, forKey: .imei)
        self.lastContactTime = try container.decodeIfPresentIgnoringCase(String.self, forKey: .lastContactTime).flatMap { $0.dateFromISO }
        self.wifi = try container.decodeIfPresentIgnoringCase(WifiRadio.self, forKey: .wifi)
        self.gatewayTime = try container.decodeIfPresentIgnoringCase(String.self, forKey: .gatewayTime).flatMap { $0.dateFromISO }
        self.vehicleId = try container.decodeIfPresentIgnoringCase(String.self, forKey: .vehicleId)
        self.location = try container.decodeIfPresentIgnoringCase(Location.self, forKey: .location)
        self.connectedState = try container.decodeIfPresentIgnoringCase(BooleanState.self, forKey: .connectedState)
        self.createdOn = try container.decodeIfPresentIgnoringCase(String.self, forKey: .createdOn).flatMap { $0.dateFromISO }
        self.lastModified = try container.decodeIfPresentIgnoringCase(String.self, forKey: .lastModified).flatMap { $0.dateFromISO }
        self.tags = try container.decodeIfPresentIgnoringCase([String].self, forKey: .tags) ?? []
        self.deleted = try container.decodeIfPresentIgnoringCase(Bool.self, forKey: .deleted) ?? false
        self.msisdn = try container.decodeIfPresentIgnoringCase(String.self, forKey: .msisdn)
        self.vendor = try container.decodeIfPresentIgnoringCase(String.self, forKey: .vendor)
        self.mainFirmware = try container.decodeIfPresentIgnoringCase(String.self, forKey: .mainFirmware)
        self.firmwareVersion = try container.decodeIfPresentIgnoringCase(String.self, forKey: .firmwareVersion)
        self.hardwareVersion = try container.decodeIfPresentIgnoringCase(String.self, forKey: .hardwareVersion)
        self.iccid = try container.decodeIfPresentIgnoringCase(String.self, forKey: .iccid)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.imei, forKey: .imei)
        try container.encodeIfPresent(self.lastContactTime, forKey: .lastContactTime)
        
        try container.encodeIfPresent(self.wifi, forKey: .wifi)
        try container.encodeIfPresent(self.gatewayTime, forKey: .gatewayTime)
        try container.encodeIfPresent(self.vehicleId, forKey: .vehicleId)
        try container.encodeIfPresent(self.location, forKey: .location)
        
        try container.encodeIfPresent(self.connectedState, forKey: .connectedState)
        try container.encodeIfPresent(self.createdOn, forKey: .createdOn)
        try container.encodeIfPresent(self.lastModified, forKey: .lastModified)
        
        try container.encodeIfPresent(self.tags, forKey: .tags)
        try container.encodeIfPresent(self.deleted, forKey: .deleted)
        try container.encodeIfPresent(self.msisdn, forKey: .msisdn)
        try container.encodeIfPresent(self.vendor, forKey: .vendor)
        try container.encodeIfPresent(self.mainFirmware, forKey: .mainFirmware)
        try container.encodeIfPresent(self.firmwareVersion, forKey: .firmwareVersion)
        try container.encodeIfPresent(self.hardwareVersion, forKey: .hardwareVersion)
        try container.encodeIfPresent(self.iccid, forKey: .iccid)
    }
}

public struct MojioUpdate: Codable {
    public var name: String? = nil
    
    public enum CodingKeys: String, CodingKey {
        case name = "Name"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.name, forKey: .name)
    }
}
