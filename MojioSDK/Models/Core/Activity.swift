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

public protocol ActivityLocationBase: Codable {
    var type: ActivityType? {get}
    var name: String? {get}
    var latitude: Double {get}
    var longitude: Double {get}
    var altitude: Double {get}
    var radius: Double {get}
}

public struct ActivityLocation: ActivityLocationBase {
    public let type: ActivityType?
    public let name: String?
    public let latitude: Double
    public let longitude: Double
    public let altitude: Double
    public let radius: Double
    
    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case name = "Name"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case altitude = "Altitude"
        case radius = "Radius"
    }
}

public protocol ActivityBase: Codable, PrimaryKey {
    
    associatedtype L: ActivityLocationBase
    
    var id: String { get }
    var type: ActivityType? { get }
    var href: String? { get }
    var name: String? { get }
    var nameMap: Dictionary<String, String>? { get }

    var location: L? {get}
    
    var startTime: Date? { get }
    var endTime: Date? { get }
    
    var context: String? { get }
    var summary: String? { get }
    var summaryMap: Dictionary<String, String>?  { get }
    
    var published: Date? { get }
    var icon: Dictionary<String, String>? {get}
}

public func ==<A: ActivityBase>(lhs: A, rhs: A) -> Bool {
    return lhs.id == rhs.id
}

public struct Activity: ActivityBase {
    
    public typealias L = ActivityLocation

    public let id: String
    public let type: ActivityType?
    public let href: String?
    public let name: String?
    public let nameMap: Dictionary<String, String>?
    
    public let location: L?
    
    public let startTime: Date?
    public let endTime: Date?
    
    public let context: String?
    public let summary: String?
    public let summaryMap: Dictionary<String, String>?
    
    public let published: Date?
    public let icon: Dictionary<String, String>?
    
    enum CodingKeys: String, CodingKey {
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
    }
}

public protocol RootActivityBase: ActivityBase {
    
    associatedtype A: ActivityBase

    var actor: A? { get }
    var target: A? { get }
    var result: A? { get }
    var object: A? { get }
    var origin: A? { get }
    var attributedTo: A? {get}
    
    var audience: A? { get }
}

public struct RootActivity: RootActivityBase {
    
    public typealias L = ActivityLocation
    public typealias A = Activity
    
    public let id: String
    public let type: ActivityType?
    public let href: String?
    public let name: String?
    public let nameMap: Dictionary<String, String>?
    
    public let location: L?
    
    public let startTime: Date?
    public let endTime: Date?
    
    public let context: String?
    public let summary: String?
    public let summaryMap: Dictionary<String, String>?
    
    public let published: Date?
    public let icon: Dictionary<String, String>?
    
    public let actor: A?
    public let target: A?
    public let result: A?
    public let object: A?
    public let origin: A?
    public let attributedTo: A?
    
    public let audience: A?
    
    enum CodingKeys: String, CodingKey {
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
        case actor = "Actor"
        case target = "Target"
        case result = "Result"
        case object = "Object"
        case origin = "Origin"
        case attributedTo = "AttributedTo"
        case audience = "Audience"
    }
}
