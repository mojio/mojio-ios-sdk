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

public protocol TripModel: Codable, PrimaryKey {
    
    associatedtype O: OdometerModel
    associatedtype L: LocationModel
    associatedtype H: HarshEventModel
    associatedtype I: IdleEventState
    associatedtype FL: FuelLevelModel
    associatedtype FE: FuelEfficiencyModel
    associatedtype D: DistanceModel
    associatedtype S: SpeedModel
    associatedtype R: RPMModel
    associatedtype A: AccelerationModel
    
    var id: String { get }
    var vehicleId: String? { get }
    var name: String? { get }
    var mojioId: String? { get }
    var ownerId: String? { get }
    var completed: Bool? { get }
    var duration: TimeInterval? { get }
    var distance: D? { get }
    var startTimestamp: Date? { get }
    var endTimestamp: Date? { get }
    var startOdometer: O? { get }
    var endOdometer: O? { get }
    var startLocation: L? { get }
    var endLocation: L? { get }
    var maxSpeed: S? { get }
    var maxRPM: R? { get }
    var maxAcceleration: A? { get }
    var maxDeceleration: A? { get }
    var polyline: String? { get }
    var harshEvents: [H] { get }
    var idleEvents: [I] { get }
    var fuelEfficiency: FE? { get }
    var startFuelLevel: FL? { get }
    var endFuelLevel: FL? { get }
    var idlingCount: Int? { get }
    var harshAccelCount: Int? { get }
    var harshDecelCount: Int? { get }
    var tags: [String] { get }
    var createdOn: Date? { get }
    var lastModified: Date? { get }
}

public struct Trip: TripModel {
    
    public typealias O = Odometer
    public typealias L = Location
    public typealias H = HarshEvent
    public typealias I = IdleEvent
    public typealias FL = FuelLevel
    public typealias FE = FuelEfficiency
    public typealias D = Distance
    public typealias S = Speed
    public typealias R = RPM
    public typealias A = Acceleration
    
    public let id: String
    public let vehicleId: String?
    public let name: String?
    public let mojioId: String?
    public let ownerId: String?
    public let completed: Bool?
    public let duration: TimeInterval?
    public let distance: D?
    public let startTimestamp: Date?
    public let endTimestamp: Date?
    public let startOdometer: O?
    public let endOdometer: O?
    public let startLocation: L?
    public let endLocation: L?
    public let maxSpeed: S?
    public let maxRPM: R?
    public let maxAcceleration: A?
    public let maxDeceleration: A?
    public let polyline: String?
    public let harshEvents: [H]
    public let idleEvents: [I]
    public let fuelEfficiency: FE?
    public let startFuelLevel: FL?
    public let endFuelLevel: FL?
    public let idlingCount: Int?
    public let harshAccelCount: Int?
    public let harshDecelCount: Int?
    public let tags: [String]
    public let createdOn: Date?
    public let lastModified: Date?
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case vehicleId = "VehicleId"
        case name = "Name"
        case mojioId = "MojioId"
        case ownerId = "OwnerId"
        case completed = "Completed"
        case duration = "Duration"
        case distance = "Distance"
        case startTimestamp = "StartTimestamp"
        case endTimestamp = "EndTimestamp"
        case startOdometer = "StartOdometer"
        case endOdometer = "EndOdometer"
        case startLocation = "StartLocation"
        case endLocation = "EndLocation"
        case maxSpeed = "MaxSpeed"
        case maxRPM = "MaxRPM"
        case maxAcceleration = "MaxAcceleration"
        case maxDeceleration = "MaxDeceleration"
        case polyline = "Polyline"
        case harshEvents = "HarshEvents"
        case idleEvents = "IdleEvents"
        case fuelEfficiency = "FuelEfficiency"
        case startFuelLevel = "StartFuelLevel"
        case endFuelLevel = "EndFuelLevel"
        case idlingCount = "IdlingCount"
        case harshAccelCount = "HarshAcclCount"
        case harshDecelCount = "HarshDecelCount"
        case tags = "Tags"
        case createdOn = "CreatedOn"
        case lastModified = "LastModified"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.id = try container.decode(String.self, forKey: .id)
            self.vehicleId = try container.decodeIfPresent(String.self, forKey: .vehicleId)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.mojioId = try container.decodeIfPresent(String.self, forKey: .mojioId)
            self.ownerId = try container.decodeIfPresent(String.self, forKey: .ownerId)
            self.completed = try container.decodeIfPresent(Bool.self, forKey: .completed) ?? false
            self.distance = try container.decodeIfPresent(Distance.self, forKey: .distance)
            self.startTimestamp = try container.decodeIfPresent(String.self, forKey: .startTimestamp).flatMap { $0.dateFromIso8601 }
            self.endTimestamp = try container.decodeIfPresent(String.self, forKey: .endTimestamp).flatMap { $0.dateFromIso8601 }
            self.startOdometer = try container.decodeIfPresent(Odometer.self, forKey: .startOdometer)
            self.endOdometer = try container.decodeIfPresent(Odometer.self, forKey: .endOdometer)
            self.startLocation = try container.decodeIfPresent(Location.self, forKey: .startLocation)
            self.endLocation = try container.decodeIfPresent(Location.self, forKey: .endLocation)
            self.maxSpeed = try container.decodeIfPresent(Speed.self, forKey: .maxSpeed)
            self.maxRPM = try container.decodeIfPresent(RPM.self, forKey: .maxRPM)
            self.maxAcceleration = try container.decodeIfPresent(Acceleration.self, forKey: .maxAcceleration)
            self.maxDeceleration = try container.decodeIfPresent(Acceleration.self, forKey: .maxDeceleration)
            self.polyline = try container.decodeIfPresent(String.self, forKey: .polyline)
            self.harshEvents = try container.decodeIfPresent([HarshEvent].self, forKey: .harshEvents) ?? []
            self.idleEvents = try container.decodeIfPresent([IdleEvent].self, forKey: .idleEvents) ?? []
            self.fuelEfficiency = try container.decodeIfPresent(FuelEfficiency.self, forKey: .fuelEfficiency)
            self.startFuelLevel = try container.decodeIfPresent(FuelLevel.self, forKey: .startFuelLevel)
            self.endFuelLevel = try container.decodeIfPresent(FuelLevel.self, forKey: .endFuelLevel)
            self.idlingCount = try container.decodeIfPresent(Int.self, forKey: .idlingCount)
            self.harshAccelCount = try container.decodeIfPresent(Int.self, forKey: .harshAccelCount)
            self.harshDecelCount = try container.decodeIfPresent(Int.self, forKey: .harshDecelCount)
            self.tags = try container.decodeIfPresent([String].self, forKey: .tags) ?? []
            self.createdOn = try container.decodeIfPresent(String.self, forKey: .createdOn).flatMap { $0.dateFromIso8601 }
            self.lastModified = try container.decodeIfPresent(String.self, forKey: .lastModified).flatMap { $0.dateFromIso8601 }
            
            if
                let duration = try container.decodeIfPresent(String.self, forKey: .duration),
                let tripDuration = TimeInterval.from(duration) {
                self.duration = tripDuration
            }
            else if let start = self.startTimestamp, let end = self.endTimestamp {
                self.duration = end.timeIntervalSince(start)
            }
            else {
                self.duration = nil
            }
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encodeIfPresent(self.vehicleId, forKey: .vehicleId)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.mojioId, forKey: .mojioId)
        try container.encodeIfPresent(self.ownerId, forKey: .ownerId)
        try container.encodeIfPresent(self.completed, forKey: .completed)
        try container.encodeIfPresent(self.distance, forKey: .distance)
        try container.encodeIfPresent(self.startTimestamp, forKey: .startTimestamp)
        try container.encodeIfPresent(self.endTimestamp, forKey: .endTimestamp)
        try container.encodeIfPresent(self.startOdometer, forKey: .startOdometer)
        try container.encodeIfPresent(self.endOdometer, forKey: .endOdometer)
        try container.encodeIfPresent(self.startLocation, forKey: .startLocation)
        try container.encodeIfPresent(self.endLocation, forKey: .endLocation)
        try container.encodeIfPresent(self.maxSpeed, forKey: .maxSpeed)
        try container.encodeIfPresent(self.maxRPM, forKey: .maxRPM)
        try container.encodeIfPresent(self.maxAcceleration, forKey: .maxAcceleration)
        try container.encodeIfPresent(self.maxDeceleration, forKey: .maxDeceleration)
        try container.encodeIfPresent(self.polyline, forKey: .polyline)
        try container.encodeIfPresent(self.harshEvents, forKey: .harshEvents)
        try container.encodeIfPresent(self.idleEvents, forKey: .idleEvents)
        try container.encodeIfPresent(self.fuelEfficiency, forKey: .fuelEfficiency)
        try container.encodeIfPresent(self.startFuelLevel, forKey: .startFuelLevel)
        try container.encodeIfPresent(self.endFuelLevel, forKey: .endFuelLevel)
        try container.encodeIfPresent(self.idlingCount, forKey: .idlingCount)
        try container.encodeIfPresent(self.harshAccelCount, forKey: .harshAccelCount)
        try container.encodeIfPresent(self.harshDecelCount, forKey: .harshDecelCount)
        try container.encodeIfPresent(self.tags, forKey: .tags)
        try container.encodeIfPresent(self.createdOn, forKey: .createdOn)
        try container.encodeIfPresent(self.lastModified, forKey: .lastModified)
        
        try container.encodeIfPresent(self.duration, forKey: .duration)
    }
}
