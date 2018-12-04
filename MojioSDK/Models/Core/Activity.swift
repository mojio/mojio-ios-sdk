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
    case telematicDevice = "TelematicDevice"
    case device = "Device"
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
    case tenant = "Tenant"
    case trip = "Trip"
    case updateDevice = "UpdateDevice"
    case user = "User"
    case vehicle = "Vehicle"
    case location = "Location"
    case unkonwn
}

internal extension ActivityType {
    init?(from intValue: Int?) {
        guard let intValue = intValue else { return nil }
        self = intValue == 1 ? .arrive : .leave
    }
}

public protocol ActivityLocationModel: Codable {
    var id: String? {get}
    var type: ActivityType? {get}
    var name: String? {get}
    var latitude: Double? {get}
    var longitude: Double? {get}
    var altitude: Double? {get}
    var radius: Double? {get}
}

extension ActivityLocationModel {
    public var hasCoordinate: Bool {
        return self.latitude != nil && self.longitude != nil
    }
}

public struct ActivityLocation: ActivityLocationModel {
    public let id: String?
    public let type: ActivityType?
    public let name: String?
    public let latitude: Double?
    public let longitude: Double?
    public let altitude: Double?
    public let radius: Double?
    
    enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case id = "Id"
        case type = "Type"
        case name = "Name"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case altitude = "Altitude"
        case radius = "Radius"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKey.self)
        
        self.id = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.id)
        self.type = try container.decodeIfPresentIgnoringCase(ActivityType.self, forKey: CodingKeys.type)
        self.name = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.name)
        self.latitude = try container.decodeIfPresentIgnoringCase(Double.self.self, forKey: CodingKeys.latitude)
        self.longitude = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.longitude)
        self.altitude = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.altitude)
        self.radius = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.radius)
    }
}

public protocol ActivityModelBase: Codable {
    typealias S = [String: String]
    typealias T = [String]
    
    var type: ActivityType? { get }
    var href: String? { get }
    var name: String? { get }
    var nameMap: S { get }
    
    var location: ActivityLocationModel? {get}
    
    var startTime: Date? { get }
    var endTime: Date? { get }
    
    var context: String? { get }
    var summary: String? { get }
    var summaryMap: S  { get }
    
    var published: Date? { get }
    var icon: Icon? {get}
    
    var duration: String? {get}
    var polyline: String? {get}
    var tags: T {get}
    var attributedTo: ActivityModel? {get}
}

public protocol ActivityModel: ActivityModelBase {
    var id: String? { get }
}

public struct Activity: ActivityModel {
    public let id: String?
    public let type: ActivityType?
    public let href: String?
    public let name: String?
    public let nameMap: S
    
    public let location: ActivityLocationModel?
    
    public let startTime: Date?
    public let endTime: Date?
    
    public let context: String?
    public let summary: String?
    public let summaryMap: S
    
    public let published: Date?
    public let icon: Icon?
    
    public let duration: String?
    public let polyline: String?
    public let tags: T
    
    public let attributedTo: ActivityModel?
    
    enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case id = "Id"
        case type = "Type"
        case href = "HRef"
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
        case attributedTo = "AttributedTo"
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: DynamicCodingKey.self)
        
        self.id = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.id)
        self.type = try container.decodeIfPresentIgnoringCase(ActivityType.self, forKey: CodingKeys.type)
        self.href = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.href)
        self.name = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.name)
        self.nameMap = try container.decodeIfPresentIgnoringCase(S.self, forKey: CodingKeys.nameMap) ?? [:]
        self.location = try container.decodeIfPresentIgnoringCase(ActivityLocation.self, forKey: CodingKeys.location)
        self.startTime = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.startTime).flatMap { $0.dateFromISO }
        self.endTime = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.endTime).flatMap { $0.dateFromISO }
        self.context = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.context)
        self.summary = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.summary)
        self.summaryMap = try container.decodeIfPresentIgnoringCase(S.self, forKey: CodingKeys.summaryMap) ?? [:]
        self.published = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.published).flatMap { $0.dateFromISO }
        self.icon = try container.decodeIfPresentIgnoringCase(Icon.self, forKey: CodingKeys.icon)
        self.duration = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.duration)
        self.polyline = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.polyline)
        self.tags = try container.decodeIfPresentIgnoringCase(T.self, forKey: CodingKeys.tags) ?? []
        self.attributedTo = try container.decodeIfPresentIgnoringCase(Activity.self, forKey: CodingKeys.attributedTo)
    }
    
    public func encode (to encoder: Encoder) throws
    {
        var container = encoder.container (keyedBy: CodingKeys.self)
        try container.encode (self.id, forKey: .id)
        try container.encode (self.type, forKey: .type)
        try container.encode (self.href, forKey: .href)
        try container.encode (self.name, forKey: .name)
        try container.encode (self.nameMap, forKey: .nameMap)
        try container.encode ((self.location as? ActivityLocation), forKey: .location)
        try container.encode (self.startTime, forKey: .startTime)
        try container.encode (self.endTime, forKey: .endTime)
        try container.encode (self.context, forKey: .context)
        try container.encode (self.summary, forKey: .summary)
        try container.encode (self.summaryMap, forKey: .summaryMap)
        try container.encode (self.published, forKey: .published)
        try container.encode (self.icon, forKey: .icon)
        try container.encode (self.duration, forKey: .duration)
        try container.encode (self.polyline, forKey: .polyline)
        try container.encode (self.tags, forKey: .tags)
        try container.encode ((self.attributedTo as? Activity), forKey: .attributedTo)
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
    case dtcDetected = "DiagnosticTroubleCode"
    case lowBattery = "LowBattery"
    case exceededSpeedLimit = "ExceededSpeedLimit"
    case tow = "Tow"
    case disturbance = "Disturbance"
    case milStatus = "MilStatus"
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
    var audience: A? { get }
}

public func ==<A: RootActivityModel>(lhs: A, rhs: A) -> Bool {
    return lhs.id == rhs.id
}


public struct RootActivity: RootActivityModel {
    
    public typealias A = Activity
    
    public let id: String
    public let type: ActivityType?
    public let href: String?
    public let name: String?
    public let nameMap: S
    
    public let location: ActivityLocationModel?
    
    public let startTime: Date?
    public let endTime: Date?
    
    public let context: String?
    public let summary: String?
    public let summaryMap: S
    
    public let published: Date?
    public let icon: Icon?
    
    public let duration: String?
    public let polyline: String?
    public let tags: T
    public let attributedTo: ActivityModel?
    public let timelineType: TimelineActivityType?
    
    public let actor: A?
    public let target: A?
    public let result: A?
    public let object: A?
    public let origin: A?
    public let audience: A?
    
    enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case id = "Id"
        case type = "Type"
        case href = "HRef"
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
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: DynamicCodingKey.self)
        
        self.id = try container.decodeIgnoringCase(String.self, forKey: CodingKeys.id)
        self.type = try container.decodeIfPresentIgnoringCase(ActivityType.self, forKey: CodingKeys.type)
        self.href = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.href)
        self.name = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.name)
        self.nameMap = try container.decodeIfPresentIgnoringCase(S.self, forKey: CodingKeys.nameMap) ?? [:]
        self.startTime = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.startTime).flatMap { $0.dateFromISO }
        self.endTime = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.endTime).flatMap { $0.dateFromISO }
        self.context = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.context)
        self.summary = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.summary)
        self.summaryMap = try container.decodeIfPresentIgnoringCase(S.self, forKey: CodingKeys.summaryMap) ?? [:]
        self.published = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.published).flatMap { $0.dateFromISO }
        self.icon = try container.decodeIfPresentIgnoringCase(Icon.self, forKey: CodingKeys.icon)
        
        self.duration = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.duration)
        self.polyline = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.polyline)
        self.tags = try container.decodeIfPresentIgnoringCase(T.self, forKey: CodingKeys.tags) ?? []
        self.attributedTo = try container.decodeIfPresentIgnoringCase(Activity.self, forKey: CodingKeys.attributedTo)
        self.timelineType = try container.decodeIfPresentIgnoringCase(TimelineActivityType.self, forKey: CodingKeys.timelineType)
        
        self.actor = try container.decodeIfPresentIgnoringCase(A.self, forKey: CodingKeys.actor)
        self.result = try container.decodeIfPresentIgnoringCase(A.self, forKey: CodingKeys.result)
        self.object = try container.decodeIfPresentIgnoringCase(A.self, forKey: CodingKeys.object)
        self.origin = try container.decodeIfPresentIgnoringCase(A.self, forKey: CodingKeys.origin)
        self.audience = try container.decodeIfPresentIgnoringCase(A.self, forKey: CodingKeys.audience)
        
        if
            let location = try container.decodeIfPresentIgnoringCase(ActivityLocation.self, forKey: CodingKeys.target),
            location.hasCoordinate
        {
            self.location = location
            self.target = nil
        }
        else if let target = try container.decodeIfPresentIgnoringCase(A.self, forKey: CodingKeys.target) {
            self.target = target
            if let location = try container.decodeIfPresentIgnoringCase(ActivityLocation.self, forKey: CodingKeys.location) {
                self.location = location
            }
            else {
                self.location = target.location
            }
        }
        else {
            self.target = nil
            self.location = try container.decodeIfPresentIgnoringCase(ActivityLocation.self, forKey: CodingKeys.location)
        }
    }
    
    public func encode (to encoder: Encoder) throws
    {
        var container = encoder.container (keyedBy: CodingKeys.self)
        try container.encode (self.id, forKey: .id)
        try container.encode (self.type, forKey: .type)
        try container.encode (self.href, forKey: .href)
        try container.encode (self.name, forKey: .name)
        try container.encode (self.nameMap, forKey: .nameMap)
        try container.encode ((self.location as? ActivityLocation), forKey: .location)
        try container.encode (self.startTime, forKey: .startTime)
        try container.encode (self.endTime, forKey: .endTime)
        try container.encode (self.context, forKey: .context)
        try container.encode (self.summary, forKey: .summary)
        try container.encode (self.summaryMap, forKey: .summaryMap)
        try container.encode (self.published, forKey: .published)
        try container.encode (self.icon, forKey: .icon)
        try container.encode (self.duration, forKey: .duration)
        try container.encode (self.polyline, forKey: .polyline)
        try container.encode (self.tags, forKey: .tags)
        try container.encode ((self.attributedTo as? Activity), forKey: .attributedTo)
        try container.encode ((self.timelineType), forKey: .timelineType)
        
        try container.encode ((self.actor), forKey: .actor)
        try container.encode ((self.result), forKey: .result)
        try container.encode ((self.object), forKey: .object)
        try container.encode ((self.origin), forKey: .origin)
        try container.encode ((self.audience), forKey: .audience)
    }
}

public struct Icon: Codable {
    
    public let name: String?
    public let type: String?
    
    enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case name = "Name"
        case type = "Type"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKey.self)
        
        self.name = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.name)
        self.type = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.type)
    }
}
