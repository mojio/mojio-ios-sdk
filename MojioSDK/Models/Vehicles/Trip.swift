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
    
    var driverScore: Int? { get }
    
    var averageDriverScore: Int? { get }
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
    
    
    public let driverScore: Int?
    
    public let averageDriverScore: Int?
    
    
    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
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

        case driverScore = "DriverScore"
        case averageDriverScore = "AverageDriverScore"
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: DynamicCodingKey.self)
        
        do {
            
            self.id = try container.decodeIgnoringCase(String.self, forKey: CodingKeys.id)
            
            self.vehicleId = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.vehicleId)
            
            self.name = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.name)
            
            self.mojioId = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.mojioId)
            
            self.ownerId = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.ownerId)
            
            self.completed = try container.decodeIfPresentIgnoringCase(Bool.self, forKey: CodingKeys.completed) ?? false
            
            self.distance = try container.decodeIfPresentIgnoringCase(Distance.self, forKey: CodingKeys.distance)
            
            self.startTimestamp = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.startTimestamp).flatMap { $0.dateFromISO }
            
            self.endTimestamp = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.endTimestamp).flatMap { $0.dateFromISO }
            
            self.startOdometer = try container.decodeIfPresentIgnoringCase(Odometer.self, forKey: CodingKeys.startOdometer)
            
            self.endOdometer = try container.decodeIfPresentIgnoringCase(Odometer.self, forKey: CodingKeys.endOdometer)
            
            self.startLocation = try container.decodeIfPresentIgnoringCase(Location.self, forKey: CodingKeys.startLocation)
            
            self.endLocation = try container.decodeIfPresentIgnoringCase(Location.self, forKey: CodingKeys.endLocation)
            
            self.maxSpeed = try container.decodeIfPresentIgnoringCase(Speed.self, forKey: CodingKeys.maxSpeed)
            
            self.maxRPM = try container.decodeIfPresentIgnoringCase(RPM.self, forKey: CodingKeys.maxRPM)
            
            self.maxAcceleration = try container.decodeIfPresentIgnoringCase(Acceleration.self, forKey: CodingKeys.maxAcceleration)
            
            self.maxDeceleration = try container.decodeIfPresentIgnoringCase(Acceleration.self, forKey: CodingKeys.maxDeceleration)
            
            self.polyline = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.polyline)
            
            self.harshEvents = try container.decodeIfPresentIgnoringCase([HarshEvent].self, forKey: CodingKeys.harshEvents) ?? []
            
            self.idleEvents = try container.decodeIfPresentIgnoringCase([IdleEvent].self, forKey: CodingKeys.idleEvents) ?? []
            
            self.fuelEfficiency = try container.decodeIfPresentIgnoringCase(FuelEfficiency.self, forKey: CodingKeys.fuelEfficiency)
            
            self.startFuelLevel = try container.decodeIfPresentIgnoringCase(FuelLevel.self, forKey: CodingKeys.startFuelLevel)
            
            self.endFuelLevel = try container.decodeIfPresentIgnoringCase(FuelLevel.self, forKey: CodingKeys.endFuelLevel)
            
            self.idlingCount = try container.decodeIfPresentIgnoringCase(Int.self, forKey: CodingKeys.idlingCount)
            
            self.harshAccelCount = try container.decodeIfPresentIgnoringCase(Int.self, forKey: CodingKeys.harshAccelCount)
            
            self.harshDecelCount = try container.decodeIfPresentIgnoringCase(Int.self, forKey: CodingKeys.harshDecelCount)
            
            self.tags = try container.decodeIfPresentIgnoringCase([String].self, forKey: CodingKeys.tags) ?? []
            
            self.createdOn = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.createdOn).flatMap { $0.dateFromISO }
            
            self.lastModified = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.lastModified).flatMap { $0.dateFromISO }
 
            
            if
                
                let duration = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.duration),
                
                let tripDuration = TimeInterval.from(duration) {
                
                self.duration = tripDuration
            }
            else if let start = self.startTimestamp, let end = self.endTimestamp {
                
                self.duration = end.timeIntervalSince(start)
            }
                
            else {
                self.duration = nil
            }
            
            if let driverScore = try container.decodeIfPresentIgnoringCase(Float.self, forKey: CodingKeys.driverScore) {
                
                self.driverScore = Int(driverScore * 100)
            }
            else {
                self.driverScore = nil
            }
            
            if let averageDriverScore = try container.decodeIfPresentIgnoringCase(Float.self, forKey: CodingKeys.averageDriverScore) {
                
                self.averageDriverScore = Int(averageDriverScore * 100)
            }
            else {
                self.averageDriverScore = nil
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
        
    
        try container.encodeIfPresent(self.driverScore, forKey: .driverScore)
        
        try container.encodeIfPresent(self.averageDriverScore, forKey: .averageDriverScore)
    }
}
