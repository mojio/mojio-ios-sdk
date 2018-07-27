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
    
    enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case type = "Type"
        case name = "Name"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case altitude = "Altitude"
        case radius = "Radius"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKey.self)
        
        self.type = try container.decodeIfPresentIgnoringCase(ActivityType.self, forKey: CodingKeys.type)
        self.name = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.name)
        self.latitude = try container.decodeIfPresentIgnoringCase(Double.self.self, forKey: CodingKeys.latitude)
        self.longitude = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.longitude)
        self.altitude = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.altitude)
        self.radius = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.radius)
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
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: DynamicCodingKey.self)
        
        self.id = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.id)
        self.type = try container.decodeIfPresentIgnoringCase(ActivityType.self, forKey: CodingKeys.type)
        self.href = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.href)
        self.name = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.name)
        self.nameMap = try container.decodeIfPresentIgnoringCase(S.self, forKey: CodingKeys.nameMap) ?? [:]
        self.location = try container.decodeIfPresentIgnoringCase(L.self, forKey: CodingKeys.location)
        self.startTime = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.startTime).flatMap { $0.dateFromISO }
        self.endTime = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.endTime).flatMap { $0.dateFromISO }
        self.context = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.context)
        self.summary = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.summary)
        self.summaryMap = try container.decodeIfPresentIgnoringCase(S.self, forKey: CodingKeys.summaryMap) ?? [:]
        self.published = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.published).flatMap { $0.dateFromISO }
        self.icon = try container.decodeIfPresentIgnoringCase(S.self, forKey: CodingKeys.summaryMap) ?? [:]
        self.duration = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.duration)
        self.polyline = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.polyline)
        self.tags = try container.decodeIfPresentIgnoringCase(T.self, forKey: CodingKeys.tags) ?? []
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
        self.icon = try container.decodeIfPresentIgnoringCase(S.self, forKey: CodingKeys.summaryMap) ?? [:]
        
        self.duration = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.duration)
        self.polyline = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.polyline)
        self.tags = try container.decodeIfPresentIgnoringCase(T.self, forKey: CodingKeys.tags) ?? []
        
        self.timelineType = try container.decodeIfPresentIgnoringCase(TimelineActivityType.self, forKey: CodingKeys.timelineType)
        self.actor = try container.decodeIfPresentIgnoringCase(A.self, forKey: CodingKeys.actor)
        self.result = try container.decodeIfPresentIgnoringCase(A.self, forKey: CodingKeys.result)
        self.object = try container.decodeIfPresentIgnoringCase(A.self, forKey: CodingKeys.object)
        self.origin = try container.decodeIfPresentIgnoringCase(A.self, forKey: CodingKeys.origin)
        self.attributedTo = try container.decodeIfPresentIgnoringCase(A.self, forKey: CodingKeys.attributedTo)
        self.audience = try container.decodeIfPresentIgnoringCase(A.self, forKey: CodingKeys.audience)
        
        if let target = try container.decodeIfPresentIgnoringCase(A.self, forKey: CodingKeys.target) {
            self.target = target
            if let location = try container.decodeIfPresentIgnoringCase(L.self, forKey: CodingKeys.location) {
                self.location = location
            }
            else {
                self.location = target.location
            }
        }
        else {
            self.location =  try container.decodeIfPresentIgnoringCase(L.self, forKey: CodingKeys.target)
            self.target = nil
        }
    }
}
