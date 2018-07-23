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

// Based on Activity Stream Data Identifiers
public enum ActivityType : String, Codable {
    case add = "Add"
    case announce = "Announce"
    case arrive = "Arrive"
    case battery = "Battery"
    case checkEngine = "CheckEngineLight"
    case device = "TelematicDevice"
    case dtc = "DiagnosticTroubleCode"
    case fuelLevel = "FuelLevel"
    case geofence = "Geofence"
    case leave = "Leave"
    case move = "Move"
    case note = "Note" // SMS or Custom Messages
    case parkingStartingSoon = "ParkingStartingSoon"
    case parkingStarted = "ParkingStarted"
    case parkingEndingSoon = "ParkingEndingSoon"
    case parkingEnded = "ParkingEnded"
    case person = "Person"
    case place = "Place"
    case asset = "Asset"
    case pet = "Pet"
    case recall = "Recall"
    case remove = "Remove"
    case speedLimit = "SpeedLimit"
    case trip = "Trip"
    case updateDevice = "UpdateDevice"
    case user = "User"
    case vehicle = "Vehicle"
    case unkonwn
}

internal extension ActivityType {
    init?(from intValue: Int?) {
        guard let intValue = intValue else { return nil }
        self = intValue == 1 ? .arrive : .leave
    }
}

public protocol ActivityLocationModel: Codable {
    var type: ActivityType? {get}
    var name: String? {get}
    var latitude: Double? {get}
    var longitude: Double? {get}
    var altitude: Double? {get}
    var radius: Double? {get}
}

public struct ActivityLocation: ActivityLocationModel {
    public let type: ActivityType?
    public let name: String?
    public let latitude: Double?
    public let longitude: Double?
    public let altitude: Double?
    public let radius: Double?
    
    enum CodingKeysPascal: String, CodingKey {
        case type = "Type"
        case name = "Name"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case altitude = "Altitude"
        case radius = "Radius"
    }
    
    enum CodingKeysCamel: String, CodingKey {
        case type = "type"
        case name = "name"
        case latitude = "latitude"
        case longitude = "longitude"
        case altitude = "altitude"
        case radius = "radius"
    }
    
    private init(container: KeyedDecodingContainer<CodingKeysPascal>) throws {
        self.type = try container.decodeIfPresent(ActivityType.self, forKey: .type)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        self.longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
        self.altitude = try container.decodeIfPresent(Double.self, forKey: .altitude)
        self.radius = try container.decodeIfPresent(Double.self, forKey: .radius)
    }
    
    private init(container: KeyedDecodingContainer<CodingKeysCamel>) throws {
        self.type = try container.decodeIfPresent(ActivityType.self, forKey: .type)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        self.longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
        self.altitude = try container.decodeIfPresent(Double.self, forKey: .altitude)
        self.radius = try container.decodeIfPresent(Double.self, forKey: .radius)
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeysPascal.self)
            _ = try container.decode(String.self, forKey: .type)
            try self.init(container: container)
        }
        catch {
            do {
                let container = try decoder.container(keyedBy: CodingKeysCamel.self)
                _ = try container.decode(String.self, forKey: .type)
                try self.init(container: container)
            }
            catch let error {
                debugPrint(error)
                throw error
            }
        }
    }
}

public protocol ActivityModelBase: Codable {
    
    associatedtype L: ActivityLocationModel
    typealias S = [String: String]
    typealias T = [String]
    
    var type: ActivityType? { get }
    var href: String? { get }
    var name: String? { get }
    var nameMap: S { get }
    
    var location: L? {get}
    
    var startTime: Date? { get }
    var endTime: Date? { get }
    
    var context: String? { get }
    var summary: String? { get }
    var summaryMap: S  { get }
    
    var published: Date? { get }
    var icon: S {get}
    
    var duration: String? {get}
    var polyline: String? {get}
    var tags: T {get}
}

public protocol ActivityModel: ActivityModelBase {
    var id: String? { get }
}

public struct Activity: ActivityModel {
    
    public typealias L = ActivityLocation
    
    public let id: String?
    public let type: ActivityType?
    public let href: String?
    public let name: String?
    public let nameMap: S
    
    public let location: L?
    
    public let startTime: Date?
    public let endTime: Date?
    
    public let context: String?
    public let summary: String?
    public let summaryMap: S
    
    public let published: Date?
    public let icon: S
    
    public let duration: String?
    public let polyline: String?
    public let tags: T
    
    enum CodingKeysPascal: String, CodingKey {
        case id = "Id"
        case type = "Type"
        case href = "Href"
        case name = "Name"
        case nameMap = "NameMap"
        case location = "Location"
        case startTime = "StartTime"
        case endTime = "EndTime"
        case context = "Context"
        case summary = "Summary"
        case summaryMap = "SummaryMap"
        case published = "Published"
        case icon = "Icon"
        case duration = "Duration"
        case polyline = "Polyline"
        case tags = "Tags"
    }
    
    enum CodingKeysCamel: String, CodingKey {
        case id = "id"
        case type = "type"
        case href = "href"
        case name = "name"
        case nameMap = "nameMap"
        case location = "location"
        case startTime = "startTime"
        case endTime = "endTime"
        case context = "context"
        case summary = "summary"
        case summaryMap = "summaryMap"
        case published = "published"
        case icon = "icon"
        case duration = "duration"
        case polyline = "polyline"
        case tags = "tags"
    }
    
    private init(container: KeyedDecodingContainer<CodingKeysPascal>) throws {
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.type = try container.decodeIfPresent(ActivityType.self, forKey: .type)
        self.href = try container.decodeIfPresent(String.self, forKey: .href)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.nameMap = try container.decodeIfPresent(S.self, forKey: .nameMap) ?? [:]
        self.location = try container.decodeIfPresent(L.self, forKey: .location)
        self.startTime = try container.decodeIfPresent(String.self, forKey: .startTime).flatMap { $0.dateFromISO }
        self.endTime = try container.decodeIfPresent(String.self, forKey: .endTime).flatMap { $0.dateFromISO }
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.summary = try container.decodeIfPresent(String.self, forKey: .summary)
        self.summaryMap = try container.decodeIfPresent(S.self, forKey: .summaryMap) ?? [:]
        self.published = try container.decodeIfPresent(String.self, forKey: .published).flatMap { $0.dateFromISO }
        self.icon = try container.decodeIfPresent(S.self, forKey: .summaryMap) ?? [:]
        self.duration = try container.decodeIfPresent(String.self, forKey: .duration)
        self.polyline = try container.decodeIfPresent(String.self, forKey: .polyline)
        self.tags = try container.decodeIfPresent(T.self, forKey: .tags) ?? []
    }
    
    private init(container: KeyedDecodingContainer<CodingKeysCamel>) throws {
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.type = try container.decodeIfPresent(ActivityType.self, forKey: .type)
        self.href = try container.decodeIfPresent(String.self, forKey: .href)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.nameMap = try container.decodeIfPresent(S.self, forKey: .nameMap) ?? [:]
        self.location = try container.decodeIfPresent(L.self, forKey: .location)
        self.startTime = try container.decodeIfPresent(String.self, forKey: .startTime).flatMap { $0.dateFromISO }
        self.endTime = try container.decodeIfPresent(String.self, forKey: .endTime).flatMap { $0.dateFromISO }
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.summary = try container.decodeIfPresent(String.self, forKey: .summary)
        self.summaryMap = try container.decodeIfPresent(S.self, forKey: .summaryMap) ?? [:]
        self.published = try container.decodeIfPresent(String.self, forKey: .published).flatMap { $0.dateFromISO }
        self.icon = try container.decodeIfPresent(S.self, forKey: .summaryMap) ?? [:]
        self.duration = try container.decodeIfPresent(String.self, forKey: .duration)
        self.polyline = try container.decodeIfPresent(String.self, forKey: .polyline)
        self.tags = try container.decodeIfPresent(T.self, forKey: .tags) ?? []
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeysPascal.self)
            _ = try container.decode(String.self, forKey: .id)
            try self.init(container: container)
        }
        catch {
            do {
                try self.init(container: try decoder.container(keyedBy: CodingKeysCamel.self))
            }
            catch let error {
                debugPrint(error)
                throw error
            }
        }
    }
}

public enum TimelineActivityType: String, Codable {
    case tripCompleted = "TripCompleted"
    case tripStarted = "TripStarted"
    case enteredGeofence = "EnteredGeofence"
    case exitedGeofence = "ExitedGeofence"
    case deviceUnplugged = "DeviceUnplugged"
    case newVehicleConnected = "NewVehicleConnected"
    case newAssetConnected = "NewAssetConnected"
    case recallNotice = "RecallNotice"
    case lowFuel = "LowFuel"
    case dtcDetected = "DTCDetected"
    case lowBattery = "LowBattery"
    case exceededSpeedLimit = "ExceededSpeedLimit"
    case tow = "Tow"
    case disturbance = "Disturbance"
    case milStatus = "MILStatus"
    case accident = "Accident"
    case serviceMessage = "ServiceMessage"
}

public protocol RootActivityModel: ActivityModelBase, PrimaryKey {
    
    associatedtype A: ActivityModel
    
    var id: String { get }
    
    var timelineType: TimelineActivityType? { get }
    
    var actor: A? { get }
    var target: A? { get }
    var result: A? { get }
    var object: A? { get }
    var origin: A? { get }
    var attributedTo: A? {get}
    
    var audience: A? { get }
}

public func ==<A: RootActivityModel>(lhs: A, rhs: A) -> Bool {
    return lhs.id == rhs.id
}


public struct RootActivity: RootActivityModel {
    
    public typealias L = ActivityLocation
    public typealias A = Activity
    
    public let id: String
    public let type: ActivityType?
    public let href: String?
    public let name: String?
    public let nameMap: S
    
    public let location: L?
    
    public let startTime: Date?
    public let endTime: Date?
    
    public let context: String?
    public let summary: String?
    public let summaryMap: S
    
    public let published: Date?
    public let icon: S
    
    public let duration: String?
    public let polyline: String?
    public let tags: T
    
    public let timelineType: TimelineActivityType?
    
    public let actor: A?
    public let target: A?
    public let result: A?
    public let object: A?
    public let origin: A?
    public let attributedTo: A?
    
    public let audience: A?
    
    enum CodingKeysPascal: String, CodingKey {
        case id = "Id"
        case type = "Type"
        case href = "Href"
        case name = "Name"
        case nameMap = "NameMap"
        case location = "Location"
        case startTime = "StartTime"
        case endTime = "EndTime"
        case context = "Context"
        case summary = "Summary"
        case summaryMap = "SummaryMap"
        case published = "Published"
        case icon = "Icon"
        case duration = "Duration"
        case polyline = "Polyline"
        case tags = "Tags"
        case timelineType = "TimelineType"
        case actor = "Actor"
        case target = "Target"
        case result = "Result"
        case object = "Object"
        case origin = "Origin"
        case attributedTo = "AttributedTo"
        case audience = "Audience"
    }
    
    enum CodingKeysCamel: String, CodingKey {
        case id = "id"
        case type = "type"
        case href = "href"
        case name = "name"
        case nameMap = "nameMap"
        case location = "location"
        case startTime = "startTime"
        case endTime = "endTime"
        case context = "context"
        case summary = "summary"
        case summaryMap = "summaryMap"
        case published = "published"
        case icon = "icon"
        case duration = "duration"
        case polyline = "polyline"
        case tags = "tags"
        case timelineType = "timelineType"
        case actor = "actor"
        case target = "target"
        case result = "result"
        case object = "object"
        case origin = "origin"
        case attributedTo = "attributedTo"
        case audience = "audience"
    }
    
    private init(container: KeyedDecodingContainer<CodingKeysPascal>) throws {
        self.id = try container.decode(String.self, forKey: .id)
        self.type = try container.decodeIfPresent(ActivityType.self, forKey: .type)
        self.href = try container.decodeIfPresent(String.self, forKey: .href)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.nameMap = try container.decodeIfPresent(S.self, forKey: .nameMap) ?? [:]
        self.startTime = try container.decodeIfPresent(String.self, forKey: .startTime).flatMap { $0.dateFromISO }
        self.endTime = try container.decodeIfPresent(String.self, forKey: .endTime).flatMap { $0.dateFromISO }
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.summary = try container.decodeIfPresent(String.self, forKey: .summary)
        self.summaryMap = try container.decodeIfPresent(S.self, forKey: .summaryMap) ?? [:]
        self.published = try container.decodeIfPresent(String.self, forKey: .published).flatMap { $0.dateFromISO }
        self.icon = try container.decodeIfPresent(S.self, forKey: .summaryMap) ?? [:]
        
        self.duration = try container.decodeIfPresent(String.self, forKey: .duration)
        self.polyline = try container.decodeIfPresent(String.self, forKey: .polyline)
        self.tags = try container.decodeIfPresent(T.self, forKey: .tags) ?? []
        
        self.timelineType = try container.decodeIfPresent(TimelineActivityType.self, forKey: .timelineType)
        self.actor = try container.decodeIfPresent(A.self, forKey: .actor)
        self.result = try container.decodeIfPresent(A.self, forKey: .result)
        self.object = try container.decodeIfPresent(A.self, forKey: .object)
        self.origin = try container.decodeIfPresent(A.self, forKey: .origin)
        self.attributedTo = try container.decodeIfPresent(A.self, forKey: .attributedTo)
        self.audience = try container.decodeIfPresent(A.self, forKey: .audience)
        
        // Timeline workaround for location set in target
        do {
            self.location = try container.decode(L.self, forKey: .target)
            self.target = nil
        }
        catch {
            self.location = try container.decodeIfPresent(L.self, forKey: .location)
            self.target = try container.decodeIfPresent(A.self, forKey: .target)
        }
    }
    
    private init(container: KeyedDecodingContainer<CodingKeysCamel>) throws {
        self.id = try container.decode(String.self, forKey: .id)
        self.type = try container.decodeIfPresent(ActivityType.self, forKey: .type)
        self.href = try container.decodeIfPresent(String.self, forKey: .href)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.nameMap = try container.decodeIfPresent(S.self, forKey: .nameMap) ?? [:]
        self.startTime = try container.decodeIfPresent(String.self, forKey: .startTime).flatMap { $0.dateFromISO }
        self.endTime = try container.decodeIfPresent(String.self, forKey: .endTime).flatMap { $0.dateFromISO }
        self.context = try container.decodeIfPresent(String.self, forKey: .context)
        self.summary = try container.decodeIfPresent(String.self, forKey: .summary)
        self.summaryMap = try container.decodeIfPresent(S.self, forKey: .summaryMap) ?? [:]
        self.published = try container.decodeIfPresent(String.self, forKey: .published).flatMap { $0.dateFromISO }
        self.icon = try container.decodeIfPresent(S.self, forKey: .summaryMap) ?? [:]
        
        self.duration = try container.decodeIfPresent(String.self, forKey: .duration)
        self.polyline = try container.decodeIfPresent(String.self, forKey: .polyline)
        self.tags = try container.decodeIfPresent(T.self, forKey: .tags) ?? []
        
        self.timelineType = try container.decodeIfPresent(TimelineActivityType.self, forKey: .timelineType)
        self.actor = try container.decodeIfPresent(A.self, forKey: .actor)
        self.result = try container.decodeIfPresent(A.self, forKey: .result)
        self.object = try container.decodeIfPresent(A.self, forKey: .object)
        self.origin = try container.decodeIfPresent(A.self, forKey: .origin)
        self.attributedTo = try container.decodeIfPresent(A.self, forKey: .attributedTo)
        self.audience = try container.decodeIfPresent(A.self, forKey: .audience)
        
        // Timeline workaround for location set in target
        do {
            self.location = try container.decode(L.self, forKey: .target)
            self.target = nil
        }
        catch {
            self.location = try container.decodeIfPresent(L.self, forKey: .location)
            self.target = try container.decodeIfPresent(A.self, forKey: .target)
        }
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeysPascal.self)
            _ = try container.decode(String.self, forKey: .id)
            try self.init(container: container)
        }
        catch {
            do {
                try self.init(container: try decoder.container(keyedBy: CodingKeysCamel.self))
            }
            catch let error {
                debugPrint(error)
                throw error
            }
        }
    }
}
