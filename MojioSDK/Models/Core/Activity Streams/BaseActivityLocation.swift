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
    case recall = "Recall"
    case remove = "Remove"
    case speedLimit = "SpeedLimit"
    case trip = "Trip"
    case updateDevice = "UpdateDevice"
    case user = "User"
    case vehicle = "Vehicle"
    case none = ""
}

public enum BaseActivityLocationCodingKeys: String, CodingKey {
    case id = "Id"
    case activityType = "Type"
    case href = "Href"
    case name = "Name"
    case nameMap = "NameMap"
}

public protocol BaseActivityLocation: PrimaryKey, Codable {
    var id: String { get }
    var activityType: ActivityType? { get }
    var href: String? { get }
    var name: String? { get }
    var nameMap: Dictionary<String, String>? { get }
}
