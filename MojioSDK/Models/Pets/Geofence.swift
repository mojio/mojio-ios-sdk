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
import MojioCore
import CoreLocation

public enum GeofenceRegionType: String, Codable {
    case circle = "Circle"
    case polygon = "Polygon"
}

public protocol GeofenceRegionModel: Codable {
    var latitude: Double? { get }
    var longitude: Double? { get }
    var radius: Double? { get }
    var polygon: String?  { get }
}

public struct GeofenceRegion: GeofenceRegionModel {
    
    public let latitude: Double?
    public let longitude: Double?
    public let radius: Double?
    public let polygon: String?
    
    public enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
        case radius = "Radius"
        case polygon = "Polygon"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
            self.longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
            self.radius = try container.decodeIfPresent(Double.self, forKey: .radius)
            self.polygon = try container.decodeIfPresent(String.self, forKey: .polygon)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

public extension GeofenceRegion {
    var coordinate: CLLocationCoordinate2D? {
        guard let latitude = self.latitude, let longitude = self.longitude else { return nil }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

public struct GeofenceRegionUpdate: Codable {
    
    public var latitude: Double?
    public var longitude: Double?
    public var radius: Double?
    public var polygon: String?
    
    public enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
        case radius = "Radius"
        case polygon = "Polygon"
    }
    
    public init(region: GeofenceRegion? = nil) {
        self.init(
            latitude: region?.latitude,
            longitude: region?.longitude,
            radius: region?.radius,
            polygon: region?.polygon
        )
    }
    
    public init(
        latitude: Double? = nil,
        longitude: Double? = nil,
        radius: Double? = nil,
        polygon: String? = nil) {
        
        self.latitude = latitude
        self.longitude = longitude
        self.radius = radius
        self.polygon = polygon
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.latitude, forKey: .latitude)
        try container.encodeIfPresent(self.longitude, forKey: .longitude)
        try container.encodeIfPresent(self.radius, forKey: .radius)
        try container.encodeIfPresent(self.polygon, forKey: .polygon)
    }
}

public protocol GeofenceNotificationModel: Codable {
    
    associatedtype W: WeekDaysModel
    
    var onEnter: Bool { get }
    var onExit: Bool { get }
    var sound: String { get }
    var activeTimeWindow: W? { get }
    var activeDaysOfWeek: [ActiveDaysOfWeek]? { get }
    var notificationMedia: NotificationMediaType? { get }
    var enabled: Bool? { get }
}

public struct GeofenceNotification: GeofenceNotificationModel {
    
    public typealias W = WeekDays
    
    public let onEnter: Bool
    public let onExit: Bool
    public let sound: String
    public let activeTimeWindow: W?
    public let activeDaysOfWeek: [ActiveDaysOfWeek]?
    public let notificationMedia: NotificationMediaType?
    public let enabled: Bool?
    
    public enum CodingKeys: String, CodingKey {
        case onEnter = "OnEnter"
        case onExit = "OnExit"
        case sound = "Sound"
        case activeTimeWindow = "ActiveTimeWindow"
        case activeDaysOfWeek = "ActiveDaysOfWeek"
        case notificationMedia = "NotificationMedia"
        case enabled = "Enabled"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.onEnter = (try container.decodeIfPresent(Bool.self, forKey: .onEnter)) ?? false
            self.onExit = (try container.decodeIfPresent(Bool.self, forKey: .onExit)) ?? false
            self.sound = (try container.decodeIfPresent(String.self, forKey: .sound)) ?? String.empty
            self.activeTimeWindow = try container.decodeIfPresent(WeekDays.self, forKey: .activeTimeWindow)
            self.activeDaysOfWeek = try container.decodeIfPresent([ActiveDaysOfWeek].self, forKey: .activeDaysOfWeek)
            //self.notificationMedia = try container.decodeIfPresent(NotificationMediaType.self, forKey: .notificationMedia)
            self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
            do {
                let petType = try container.decode(String.self, forKey: .notificationMedia)
                self.notificationMedia = NotificationMediaType(stringValue: petType)
            }
            catch {
                self.notificationMedia = NotificationMediaType(stringValue: "Unspecified")
            }
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.onEnter, forKey: .onEnter)
        try container.encodeIfPresent(self.onExit, forKey: .onExit)
        try container.encodeIfPresent(self.sound, forKey: .sound)
        try container.encodeIfPresent(self.activeTimeWindow, forKey: .activeTimeWindow)
        try container.encodeIfPresent(self.activeDaysOfWeek, forKey: .activeDaysOfWeek)
        try container.encodeIfPresent(self.notificationMedia?.description, forKey: .notificationMedia)
        try container.encodeIfPresent(self.enabled, forKey: .enabled)
    }
}

public struct GeofenceNotificationUpdate: Codable {
    public let onEnter: Bool
    public let onExit: Bool
    public let sound: String
    public var activeTimeWindow: WeekDaysUpdate?
    public var activeDaysOfWeek: [ActiveDaysOfWeek]?
    public var notificationMedia: NotificationMediaType?
    public var enabled: Bool?
    
    public init(notification: GeofenceNotification? = nil) {
        self.init(
            onEnter: notification?.onEnter ?? false,
            onExit: notification?.onExit ?? false,
            sound: notification?.sound ?? "",
            activeTimeWindow: WeekDaysUpdate(model: notification?.activeTimeWindow),
            activeDaysOfWeek: notification?.activeDaysOfWeek,
            notificationMedia: notification?.notificationMedia,
            enabled: notification?.enabled
        )
    }
    
    public init(
        onEnter: Bool,
        onExit: Bool,
        sound: String,
        activeTimeWindow: WeekDaysUpdate? = nil,
        activeDaysOfWeek: [ActiveDaysOfWeek]? = nil,
        notificationMedia: NotificationMediaType? = nil,
        enabled: Bool? = nil) {
        
        self.onEnter = onEnter
        self.onExit = onExit
        self.sound = sound
        self.activeTimeWindow = activeTimeWindow
        self.activeDaysOfWeek = activeDaysOfWeek
        self.notificationMedia = notificationMedia
        self.enabled = enabled
    }
    
    public enum CodingKeys: String, CodingKey {
        case onEnter = "OnEnter"
        case onExit = "OnExit"
        case sound = "Sound"
        case activeTimeWindow = "ActiveTimeWindow"
        case activeDaysOfWeek = "ActiveDaysOfWeek"
        case notificationMedia = "NotificationMedia"
        case enabled = "Enabled"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.onEnter = (try container.decodeIfPresent(Bool.self, forKey: .onEnter)) ?? false
            self.onExit = (try container.decodeIfPresent(Bool.self, forKey: .onExit)) ?? false
            self.sound = (try container.decodeIfPresent(String.self, forKey: .sound)) ?? String.empty
            self.activeTimeWindow = try container.decodeIfPresent(WeekDaysUpdate.self, forKey: .activeTimeWindow)
            self.activeDaysOfWeek = try container.decodeIfPresent([ActiveDaysOfWeek].self, forKey: .activeDaysOfWeek)
            //self.notificationMedia = try container.decodeIfPresent(NotificationMediaType.self, forKey: .notificationMedia)
            self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
            do {
                let petType = try container.decode(String.self, forKey: .notificationMedia)
                self.notificationMedia = NotificationMediaType(stringValue: petType)
            }
            catch {
                self.notificationMedia = NotificationMediaType(stringValue: "Unspecified")
            }
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.onEnter, forKey: .onEnter)
        try container.encodeIfPresent(self.onExit, forKey: .onExit)
        try container.encodeIfPresent(self.sound, forKey: .sound)
        try container.encodeIfPresent(self.activeTimeWindow, forKey: .activeTimeWindow)
        try container.encodeIfPresent(self.activeDaysOfWeek, forKey: .activeDaysOfWeek)
        try container.encodeIfPresent(self.notificationMedia?.description, forKey: .notificationMedia)
        try container.encodeIfPresent(self.enabled, forKey: .enabled)
    }
}

public protocol SeparateGeofenceNotificationModel: Codable {
    associatedtype W: WeekDaysModel
    
    var enabled: Bool { get }
    var sound: String { get }
    var activeTimeWindow: W? { get }
    var activeDaysOfWeek: [ActiveDaysOfWeek]? { get }
    var notificationMedia: NotificationMediaType? { get }
}

public struct SeparateGeofenceNotification: SeparateGeofenceNotificationModel {
    public typealias W = WeekDays
    
    public let enabled: Bool
    public let sound: String
    public let activeTimeWindow: W?
    public let activeDaysOfWeek: [ActiveDaysOfWeek]?
    public let notificationMedia: NotificationMediaType?
    
    public enum CodingKeys: String, CodingKey {
        case enabled = "Enabled"
        case sound = "Sound"
        case activeTimeWindow = "ActiveTimeWindow"
        case activeDaysOfWeek = "ActiveDaysOfWeek"
        case notificationMedia = "NotificationMedia"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.enabled = try container.decode(Bool.self, forKey: .enabled)
            self.sound = (try container.decode(String.self, forKey: .sound))
            self.activeTimeWindow = try container.decodeIfPresent(WeekDays.self, forKey: .activeTimeWindow)
            self.activeDaysOfWeek = try container.decodeIfPresent([ActiveDaysOfWeek].self, forKey: .activeDaysOfWeek)
            //self.notificationMedia = try container.decodeIfPresent(NotificationMediaType.self, forKey: .notificationMedia)
            do {
                let petType = try container.decode(String.self, forKey: .notificationMedia)
                self.notificationMedia = NotificationMediaType(stringValue: petType)
            }
            catch {
                self.notificationMedia = NotificationMediaType(stringValue: "Unspecified")
            }
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.enabled, forKey: .enabled)
        try container.encodeIfPresent(self.sound, forKey: .sound)
        try container.encodeIfPresent(self.activeTimeWindow, forKey: .activeTimeWindow)
        try container.encodeIfPresent(self.activeDaysOfWeek, forKey: .activeDaysOfWeek)
        try container.encodeIfPresent(self.notificationMedia?.description, forKey: .notificationMedia)
    }
}

public struct SeparateGeofenceNotificationUpdate: Codable {
    public var enabled: Bool
    public var sound: String
    public var activeTimeWindow: WeekDaysUpdate?
    public var activeDaysOfWeek: [ActiveDaysOfWeek]?
    public var notificationMedia: NotificationMediaType?
    
    public init(separateGeofenceNotification: SeparateGeofenceNotification? = nil) {
        self.init(
            enabled: separateGeofenceNotification?.enabled ?? false,
            sound: separateGeofenceNotification?.sound ?? "",
            activeTimeWindow: WeekDaysUpdate(model: separateGeofenceNotification?.activeTimeWindow),
            activeDaysOfWeek: separateGeofenceNotification?.activeDaysOfWeek,
            notificationMedia: separateGeofenceNotification?.notificationMedia
        )
    }
    
    public init(enabled: Bool,
                sound: String,
                activeTimeWindow: WeekDaysUpdate? = nil,
                activeDaysOfWeek: [ActiveDaysOfWeek]? = nil,
                notificationMedia: NotificationMediaType? = nil) {
        self.enabled = enabled
        self.sound = sound
        self.activeTimeWindow = activeTimeWindow
        self.activeDaysOfWeek = activeDaysOfWeek
        self.notificationMedia = notificationMedia
    }
    
    public enum CodingKeys: String, CodingKey {
        case enabled = "Enabled"
        case sound = "Sound"
        case activeTimeWindow = "ActiveTimeWindow"
        case activeDaysOfWeek = "ActiveDaysOfWeek"
        case notificationMedia = "NotificationMedia"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.enabled = try container.decode(Bool.self, forKey: .enabled)
            self.sound = (try container.decode(String.self, forKey: .sound))
            self.activeTimeWindow = try container.decodeIfPresent(WeekDaysUpdate.self, forKey: .activeTimeWindow)
            self.activeDaysOfWeek = try container.decodeIfPresent([ActiveDaysOfWeek].self, forKey: .activeDaysOfWeek)
            //self.notificationMedia = try container.decodeIfPresent(NotificationMediaType.self, forKey: .notificationMedia)
            do {
                let petType = try container.decode(String.self, forKey: .notificationMedia)
                self.notificationMedia = NotificationMediaType(stringValue: petType)
            }
            catch {
                self.notificationMedia = NotificationMediaType(stringValue: "Unspecified")
            }
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.enabled, forKey: .enabled)
        try container.encodeIfPresent(self.sound, forKey: .sound)
        try container.encodeIfPresent(self.activeTimeWindow, forKey: .activeTimeWindow)
        try container.encodeIfPresent(self.activeDaysOfWeek, forKey: .activeDaysOfWeek)
        try container.encodeIfPresent(self.notificationMedia?.description, forKey: .notificationMedia)
    }
}

public protocol GeofenceWiFiModel: Codable {
    var ssid: String? { get }
    var macAddress: String? { get }
    var signalStrength: Int? { get }
}

public struct GeofenceWiFi: GeofenceWiFiModel {
    public let ssid: String?
    public let macAddress: String?
    public let signalStrength: Int?
    
    public enum CodingKeys: String, CodingKey {
        case ssid = "Ssid"
        case macAddress = "MacAddress"
        case signalStrength = "SignalStrength"
    }
    
    public init(ssid: String, macAddress: String? = nil, signalStrength: Int? = nil) {
        self.ssid = ssid
        self.macAddress = macAddress
        self.signalStrength = signalStrength
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.ssid = try container.decodeIfPresent(String.self, forKey: .ssid)
            self.macAddress = try container.decodeIfPresent(String.self, forKey: .macAddress)
            self.signalStrength = try container.decodeIfPresent(Int.self, forKey: .signalStrength)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

public struct GeofenceWiFiUpdate: GeofenceWiFiModel {
    public let ssid: String?
    public let macAddress: String?
    public let signalStrength: Int?
    
    public enum CodingKeys: String, CodingKey {
        case ssid = "Ssid"
        case macAddress = "MacAddress"
        case signalStrength = "SignalStrength"
    }
    
    public init(geofenceWifi: GeofenceWiFi? = nil) {
        self.init(
            ssid: geofenceWifi?.ssid ?? "",
            macAddress: geofenceWifi?.macAddress,
            signalStrength: geofenceWifi?.signalStrength
        )
    }
    
    public init(ssid: String, macAddress: String? = nil, signalStrength: Int? = nil) {
        self.ssid = ssid
        self.macAddress = macAddress
        self.signalStrength = signalStrength
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.ssid, forKey: .ssid)
        try container.encodeIfPresent(self.macAddress, forKey: .macAddress)
        try container.encodeIfPresent(self.signalStrength, forKey: .signalStrength)
    }
}

public protocol GeofenceModel: Codable, PrimaryKey {
    
    associatedtype G: GeofenceRegionModel
    associatedtype N: GeofenceNotificationModel
    associatedtype W: GeofenceWiFiModel
    associatedtype SG: SeparateGeofenceNotificationModel
    
    var id: String { get }
    var name: String? { get }
    var description: String? { get }
    var region: G? { get }
    var notification: N? { get }
    var assetIds: [String] { get }
    var ownerId: String? { get }
    var deleted: Bool? { get }
    var lastModified: Date? { get }
    var createdOn: Date? { get }
    
    var wifi: W? { get }
    var geofenceEnterNotification: SG? { get }
    var geofenceExitNotification: SG? { get }
}

public struct Geofence: GeofenceModel {
    
    public typealias G = GeofenceRegion
    public typealias N = GeofenceNotification
    public typealias W = GeofenceWiFi
    public typealias SG = SeparateGeofenceNotification
    
    public let id: String
    public let name: String?
    public let description: String?
    public let region: G?
    public let notification: N?
    public let assetIds: [String]
    public let ownerId: String?
    public let deleted: Bool?
    public let lastModified: Date?
    public let createdOn: Date?
    
    public let geofenceEnterNotification: SG?
    public let geofenceExitNotification: SG?
    
    
    public let wifi: W?
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case description = "Description"
        case region = "Region"
        case notification = "Notification"
        case assetIds = "AssetIds"
        case ownerId = "OwnerId"
        case deleted = "Deleted"
        case lastModified = "LastModified"
        case createdOn = "CreatedOn"
        
        case wifi = "Wifi"
        
        case geofenceEnterNotification = "GeofenceEnterNotification"
        case geofenceExitNotification = "GeofenceExitNotification"
        
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.id = try container.decode(String.self, forKey: .id)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.region = try container.decodeIfPresent(G.self, forKey: .region)
            self.notification = try container.decodeIfPresent(N.self, forKey: .notification)
            self.assetIds = try container.decodeIfPresent([String].self, forKey: .assetIds) ?? []
            self.ownerId = try container.decodeIfPresent(String.self, forKey: .ownerId)
            self.deleted = try container.decodeIfPresent(Bool.self, forKey: .deleted)
            self.lastModified = try container.decodeIfPresent(String.self, forKey: .lastModified).flatMap { $0.dateFromISO }
            self.createdOn = try container.decodeIfPresent(String.self, forKey: .createdOn).flatMap { $0.dateFromISO }
            
            self.wifi = try container.decodeIfPresent(W.self, forKey: .wifi)
            
            self.geofenceEnterNotification = try container.decodeIfPresent(SG.self, forKey: .geofenceEnterNotification)
            self.geofenceExitNotification = try container.decodeIfPresent(SG.self, forKey: .geofenceExitNotification)
            
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

public func ==(lhs: Geofence, rhs: Geofence) -> Bool {
    return lhs.id == rhs.id
}

public struct GeofenceUpdate: Codable {
    public var name: String? = nil
    public var description: String? = nil
    public var region: GeofenceRegionUpdate? = nil
    public var notification: GeofenceNotificationUpdate? = nil
    public var geofenceEnterNotification: SeparateGeofenceNotificationUpdate?
    public var geofenceExitNotification: SeparateGeofenceNotificationUpdate?
    public var assetIds: [String] = []
    public var wifi: GeofenceWiFiUpdate? = nil
    
    public init(geofence: Geofence? = nil) {
        self.init(
            name: geofence?.name,
            description: geofence?.description,
            region: GeofenceRegionUpdate(region: geofence?.region),
            notification: GeofenceNotificationUpdate(notification: geofence?.notification),
            geofenceEnterNotification: SeparateGeofenceNotificationUpdate(separateGeofenceNotification: geofence?.geofenceEnterNotification),
            geofenceExitNotification: SeparateGeofenceNotificationUpdate(separateGeofenceNotification: geofence?.geofenceExitNotification),
            wifi: GeofenceWiFiUpdate(geofenceWifi: geofence?.wifi),
            assetIds: geofence?.assetIds ?? []
        )
    }
    
    public init(
        name: String? = nil,
        description: String? = nil,
        region: GeofenceRegionUpdate? = nil,
        notification: GeofenceNotificationUpdate? = nil,
        geofenceEnterNotification: SeparateGeofenceNotificationUpdate? = nil,
        geofenceExitNotification: SeparateGeofenceNotificationUpdate? = nil,
        wifi: GeofenceWiFiUpdate? = nil,
        assetIds: [String] = []) {
        
        self.name = name
        self.description = description
        self.region = region
        self.notification = notification
        self.geofenceEnterNotification = geofenceEnterNotification
        self.geofenceExitNotification = geofenceExitNotification
        self.assetIds = assetIds
        
        self.wifi = wifi
    }
    
    public enum CodingKeys: String, CodingKey {
        case name = "Name"
        case description = "Description"
        case region = "Region"
        case notification = "Notification"
        case assetIds = "AssetIds"
        case wifi = "Wifi"
        case geofenceEnterNotification = "GeofenceEnterNotification"
        case geofenceExitNotification = "GeofenceExitNotification"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.region, forKey: .region)
        try container.encodeIfPresent(self.notification, forKey: .notification)
        try container.encodeIfPresent(self.assetIds, forKey: .assetIds)
        
        try container.encodeIfPresent(self.wifi, forKey: .wifi)
        
        try container.encodeIfPresent(self.geofenceEnterNotification, forKey: .geofenceEnterNotification)
        try container.encodeIfPresent(self.geofenceExitNotification, forKey: .geofenceExitNotification)
    }
}
