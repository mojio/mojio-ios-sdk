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
        case iccid = "ICCID"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.imei = try container.decodeIfPresent(String.self, forKey: .imei)
        self.lastContactTime = try container.decodeIfPresent(String.self, forKey: .lastContactTime).flatMap { $0.dateFromIso8601 }
        self.wifi = try container.decodeIfPresent(WifiRadio.self, forKey: .wifi)
        self.gatewayTime = try container.decodeIfPresent(String.self, forKey: .gatewayTime).flatMap { $0.dateFromIso8601 }
        self.vehicleId = try container.decodeIfPresent(String.self, forKey: .vehicleId)
        self.location = try container.decodeIfPresent(Location.self, forKey: .location)
        self.connectedState = try container.decodeIfPresent(BooleanState.self, forKey: .connectedState)
        self.createdOn = try container.decodeIfPresent(String.self, forKey: .createdOn).flatMap { $0.dateFromIso8601 }
        self.lastModified = try container.decodeIfPresent(String.self, forKey: .lastModified).flatMap { $0.dateFromIso8601 }
        self.tags = try container.decodeIfPresent([String].self, forKey: .tags) ?? []
        self.deleted = try container.decodeIfPresent(Bool.self, forKey: .deleted) ?? false
        self.msisdn = try container.decodeIfPresent(String.self, forKey: .msisdn)
        self.iccid = try container.decodeIfPresent(String.self, forKey: .iccid)
    }
    
    public func encode(to encoder: Encoder) throws {

    }
}
