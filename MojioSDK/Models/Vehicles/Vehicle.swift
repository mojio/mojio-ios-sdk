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

public protocol GeneralVehicle {
    
    associatedtype C: GeneralVehicleCompatibilityDetails
    associatedtype D: GeneralDiagnosticCode
    associatedtype AR: GeneralAccelerometer
    associatedtype AN: GeneralAcceleration
    associatedtype O: GeneralOdometer
    associatedtype FL: GeneralFuelLevel
    associatedtype FE: GeneralFuelEfficiency
    associatedtype FV: GeneralFuelVolume
    associatedtype HS: GeneralHarshEventState
    associatedtype IS: GeneralIdleState
    associatedtype BS: GeneralBooleanState
    associatedtype L: GeneralLocation
    associatedtype V: GeneralVinDetails
    associatedtype B: GeneralBattery
    associatedtype H: GeneralHeading
    associatedtype S: GeneralSpeed
    associatedtype R: GeneralRPM
    
    var id: String { get }
    var name: String? { get }
    var licensePlate: String? { get }
    var vin: String? { get }
    var detectedVIN: String? { get }
    var overrideVIN: String? { get }
    var compatDetails: C? { get }
    var currentTrip: String? { get }
    var mojioId: String? { get }
    var milStatus: Bool { get }
    var lastContactTime: Date? { get }
    var diagnosticCodes: [D] { get }
    var accelerometer: AR? { get }
    var acceleration: AN? { get }
    var deceleration: AN? { get }
    var speed: S? { get }
    var odometer: O? { get }
    var virtualOdometer: O? { get }
    var rpm: R? { get }
    var fuelEfficiency: FE? { get }
    var fuelEfficiencyCalculationMethod: FuelEfficiencyCalculationMethod? { get }
    var fuelLevel: FL? { get }
    var fuelVolume: FV? { get }
    var fuelType: FuelType? { get }
    var gatewayTime: Date? { get }
    var harshEventState: HS? { get }
    var idleState: IS? { get }
    var ignitionState: BS? { get }
    var battery: B? { get }
    var heading: H? { get }
    var location: L? { get }
    var accidentState: BS? { get }
    var vinDetails: V? { get }
    var towState: BS? { get }
    var parkedState: BS? { get }
    var tags: [String] { get }
    var ownerGroups: [String] { get }
    var deleted: Bool { get }
    var createdOn: Date? { get }
    var lastModified: Date? { get }
}

public struct Vehicle: Codable, PrimaryKey, GeneralVehicle {
    
    public typealias B = Battery
    public typealias H = Heading
    public typealias AR = Accelerometer
    public typealias AN = Acceleration
    public typealias FL = FuelLevel
    public typealias FE = FuelEfficiency
    public typealias FV = FuelVolume
    public typealias HS = HarshEventState
    public typealias IS = IdleState
    public typealias BS = BooleanState
    public typealias S = Speed
    public typealias R = RPM
    public typealias C = CompatibilityDetails
    public typealias D = DiagnosticCode
    public typealias O = Odometer
    public typealias V = VinDetails
    public typealias L = Location
    
    public var id: String
    public var name: String?
    public var licensePlate: String?
    public var vin: String?
    public var detectedVIN: String?
    public var overrideVIN: String?
    public var compatDetails: C?
    public var currentTrip: String?
    public var mojioId: String?
    public var milStatus: Bool
    public var lastContactTime: Date?
    public var diagnosticCodes: [D]
    public var accelerometer: AR?
    public var acceleration: AN?
    public var deceleration: AN?
    public var speed: S?
    public var odometer: O?
    public var virtualOdometer: O?
    public var rpm: R?
    public var fuelEfficiency: FE?
    public var fuelEfficiencyCalculationMethod: FuelEfficiencyCalculationMethod?
    public var fuelLevel: FL?
    public var fuelVolume: FV?
    public var fuelType: FuelType?
    public var gatewayTime: Date?
    public var harshEventState: HS?
    public var idleState: IS?
    public var ignitionState: BS?
    public var battery: B?
    public var heading: H?
    public var location: L?
    public var accidentState: BS?
    public var vinDetails: V?
    public var towState: BS?
    public var parkedState: BS?
    public var tags: [String]
    public var ownerGroups: [String]
    public var deleted: Bool
    public var createdOn: Date?
    public var lastModified: Date?
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case licensePlate = "LicensePlate"
        case vin = "VIN"
        case detectedVIN = "DetectedVIN"
        case overrideVIN = "OverrideVIN"
        case compatDetails = "CompatDetails"
        case currentTrip = "CurrentTrip"
        case mojioId = "MojioId"
        case milStatus = "MilStatus"
        case diagnosticCodes = "DiagnosticCodes"
        case lastContactTime = "LastContactTime"
        case accelerometer = "Accelerometer"
        case acceleration = "Acceleration"
        case deceleration = "Deceleration"
        case speed = "Speed"
        case odometer = "Odometer"
        case virtualOdometer = "VirtualOdometer"
        case rpm = "RPM"
        case fuelEfficiency = "FuelEfficiency"
        case fuelEfficiencyCalculationMethod = "FuelEfficiencyCalculationMethod"
        case fuelLevel = "FuelLevel"
        case fuelVolume = "FuelVolume"
        case fuelType = "FuelType"
        case gatewayTime = "GatewayTime"
        case harshEventState = "HarshEventState"
        case idleState = "IdleState"
        case ignitionState = "IgnitionState"
        case battery = "Battery"
        case heading = "Heading"
        case location = "Location"
        case accidentState = "AccidentState"
        case vinDetails = "VinDetails"
        case towState = "TowState"
        case parkedState = "ParkedState"
        case ownerGroups = "OwnerGroups"
        case tags = "Tags"
        case deleted = "Deleted"
        case createdOn = "CreatedOn"
        case lastModified = "LastModified"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.id = try container.decode(String.self, forKey: .id)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.licensePlate = try container.decodeIfPresent(String.self, forKey: .licensePlate)
            self.vin = try container.decodeIfPresent(String.self, forKey: .vin)
            self.detectedVIN = try container.decodeIfPresent(String.self, forKey: .detectedVIN)
            self.overrideVIN = try container.decodeIfPresent(String.self, forKey: .overrideVIN)
            self.mojioId = try container.decodeIfPresent(String.self, forKey: .mojioId)
            self.compatDetails = try container.decodeIfPresent(CompatibilityDetails.self, forKey: .compatDetails)
            self.currentTrip = try container.decodeIfPresent(String.self, forKey: .currentTrip)
            self.milStatus = try container.decodeIfPresent(Bool.self, forKey: .milStatus) ?? false
            self.diagnosticCodes = try container.decodeIfPresent([DiagnosticCode].self, forKey: .diagnosticCodes) ?? []
            self.lastContactTime = try container.decodeIfPresent(String.self, forKey: .lastContactTime).flatMap { $0.dateFromIso8601 }
            self.accelerometer = try container.decodeIfPresent(Accelerometer.self, forKey: .accelerometer)
            self.acceleration = try container.decodeIfPresent(Acceleration.self, forKey: .acceleration)
            self.deceleration = try container.decodeIfPresent(Acceleration.self, forKey: .deceleration)
            
            self.speed = try container.decodeIfPresent(Speed.self, forKey: .speed)
            self.odometer = try container.decodeIfPresent(Odometer.self, forKey: .odometer)
            self.virtualOdometer = try container.decodeIfPresent(Odometer.self, forKey: .virtualOdometer)
            self.rpm = try container.decodeIfPresent(RPM.self, forKey: .rpm)
            self.fuelEfficiency = try container.decodeIfPresent(FuelEfficiency.self, forKey: .fuelEfficiency)
            self.fuelEfficiencyCalculationMethod = try container.decodeIfPresent(FuelEfficiencyCalculationMethod.self, forKey: .fuelEfficiencyCalculationMethod)
            self.fuelLevel = try container.decodeIfPresent(FuelLevel.self, forKey: .fuelLevel)
            self.fuelVolume = try container.decodeIfPresent(FuelVolume.self, forKey: .fuelVolume)
            self.fuelType = try container.decodeIfPresent(FuelType.self, forKey: .fuelType)
            self.gatewayTime = try container.decodeIfPresent(String.self, forKey: .gatewayTime).flatMap { $0.dateFromIso8601 }
            self.harshEventState = try container.decodeIfPresent(HarshEventState.self, forKey: .harshEventState)
            self.idleState = try container.decodeIfPresent(IdleState.self, forKey: .idleState)
            self.ignitionState = try container.decodeIfPresent(BooleanState.self, forKey: .ignitionState)
            self.battery = try container.decodeIfPresent(Battery.self, forKey: .battery)
            self.heading = try container.decodeIfPresent(Heading.self, forKey: .heading)
            self.location = try container.decodeIfPresent(Location.self, forKey: .location)
            self.accidentState = try container.decodeIfPresent(BooleanState.self, forKey: .accidentState)
            self.vinDetails = try container.decodeIfPresent(VinDetails.self, forKey: .vinDetails)
            self.towState = try container.decodeIfPresent(BooleanState.self, forKey: .towState)
            self.parkedState = try container.decodeIfPresent(BooleanState.self, forKey: .parkedState)
            self.ownerGroups = try container.decodeIfPresent([String].self, forKey: .ownerGroups) ?? []
            self.tags = try container.decodeIfPresent([String].self, forKey: .tags) ?? []
            self.deleted = try container.decodeIfPresent(Bool.self, forKey: .deleted) ?? false
            self.createdOn = try container.decodeIfPresent(String.self, forKey: .createdOn).flatMap { $0.dateFromIso8601 }
            self.lastModified = try container.decodeIfPresent(String.self, forKey: .lastModified).flatMap { $0.dateFromIso8601 }
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}

public func ==(lhs: Vehicle, rhs: Vehicle) -> Bool {
    return lhs.id == rhs.id
}
