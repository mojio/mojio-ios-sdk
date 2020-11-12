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

public enum VehicleType: String, Codable {
    case physical = "Physical"
    case ghost = "Ghost"
    case bluetooth = "Bluetooth"
    case unknown = "Unknown"

    public init(from decoder: Decoder) throws {
        let rawValue = try decoder.singleValueContainer().decode(String.self)
        self = VehicleType(rawValue: rawValue) ?? .unknown
    }
}

public protocol VehicleModel: Codable, PrimaryKey {
    
    associatedtype C: CompatibilityDetailsModel
    associatedtype D: DiagnosticCodeModel
    associatedtype AR: AccelerometerModel
    associatedtype AN: AccelerationModel
    associatedtype O: OdometerModel
    associatedtype FL: FuelLevelModel
    associatedtype FE: FuelEfficiencyModel
    associatedtype FV: FuelVolumeModel
    associatedtype HS: HarshEventStateModel
    associatedtype IS: IdleStateModel
    associatedtype BS: BooleanStateModel
    associatedtype L: LocationModel
    associatedtype V: VinDetailsModel
    associatedtype B: BatteryModel
    associatedtype H: HeadingModel
    associatedtype S: SpeedModel
    associatedtype R: RPMModel
    associatedtype EO: EngineOilModel
    associatedtype TP: TirePressureModel
    associatedtype PM: PredictiveMaintenanceModel
    
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
    var realOdometer: O? { get }
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
    var engineOil: EO? { get }
    var tirePressure: TP? { get }
    var predictiveMaintenance: PM? { get }
    var vehicleType: VehicleType? { get }
    var alternateId: String? { get } // ID of Bluetooth device linked to virtual vehicles
}

public struct Vehicle: VehicleModel {
    
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
    public typealias EO = EngineOil
    public typealias TP = TirePressure
    public typealias PM = PredictiveMaintenance
    
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
    public var realOdometer: O?
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
    public var engineOil: EO?
    public var tirePressure: TP?
    public var predictiveMaintenance: PM?
    public var vehicleType: VehicleType?
    public var alternateId: String?
    
    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
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
        case realOdometer = "RealOdometer"
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
        case engineOil = "EngineOil"
        case tirePressure = "TirePressure"
        case predictiveMaintenance = "PredictiveMaintenance"
        case vehicleType = "VehicleType"
        case alternateId = "AlternateId"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            
            self.id = try container.decodeIgnoringCase(String.self, forKey: CodingKeys.id)
            self.name = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.name)
            self.licensePlate = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.licensePlate)
            self.vin = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.vin)
            self.detectedVIN = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.detectedVIN)
            self.overrideVIN = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.overrideVIN)
            self.mojioId = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.mojioId)
            self.compatDetails = try container.decodeIfPresentIgnoringCase(CompatibilityDetails.self, forKey: CodingKeys.compatDetails)
            self.currentTrip = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.currentTrip)
            self.milStatus = try container.decodeIfPresentIgnoringCase(Bool.self, forKey: CodingKeys.milStatus) ?? false
            self.diagnosticCodes = try container.decodeIfPresentIgnoringCase([DiagnosticCode].self, forKey: CodingKeys.diagnosticCodes) ?? []
            self.lastContactTime = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.lastContactTime).flatMap { $0.dateFromISO }
            self.accelerometer = try container.decodeIfPresentIgnoringCase(Accelerometer.self, forKey: CodingKeys.accelerometer)
            self.acceleration = try container.decodeIfPresentIgnoringCase(Acceleration.self, forKey: CodingKeys.acceleration)
            self.deceleration = try container.decodeIfPresentIgnoringCase(Acceleration.self, forKey: CodingKeys.deceleration)
            
            self.speed = try container.decodeIfPresentIgnoringCase(Speed.self, forKey: CodingKeys.speed)
            self.odometer = try container.decodeIfPresentIgnoringCase(Odometer.self, forKey: CodingKeys.odometer)
            self.virtualOdometer = try container.decodeIfPresentIgnoringCase(Odometer.self, forKey: CodingKeys.virtualOdometer)
            self.realOdometer = try container.decodeIfPresentIgnoringCase(Odometer.self, forKey: CodingKeys.realOdometer)
            self.rpm = try container.decodeIfPresentIgnoringCase(RPM.self, forKey: CodingKeys.rpm)
            self.fuelEfficiency = try container.decodeIfPresentIgnoringCase(FuelEfficiency.self, forKey: CodingKeys.fuelEfficiency)
            self.fuelEfficiencyCalculationMethod = try container.decodeIfPresentIgnoringCase(FuelEfficiencyCalculationMethod.self, forKey: CodingKeys.fuelEfficiencyCalculationMethod)
            self.fuelLevel = try container.decodeIfPresentIgnoringCase(FuelLevel.self, forKey: CodingKeys.fuelLevel)
            self.fuelVolume = try container.decodeIfPresentIgnoringCase(FuelVolume.self, forKey: CodingKeys.fuelVolume)
            self.fuelType = try container.decodeIfPresentIgnoringCase(FuelType.self, forKey: CodingKeys.fuelType)
            self.gatewayTime = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.gatewayTime).flatMap { $0.dateFromISO }
            self.harshEventState = try container.decodeIfPresentIgnoringCase(HarshEventState.self, forKey: CodingKeys.harshEventState)
            self.idleState = try container.decodeIfPresentIgnoringCase(IdleState.self, forKey: CodingKeys.idleState)
            self.ignitionState = try container.decodeIfPresentIgnoringCase(BooleanState.self, forKey: CodingKeys.ignitionState)
            self.battery = try container.decodeIfPresentIgnoringCase(Battery.self, forKey: CodingKeys.battery)
            self.heading = try container.decodeIfPresentIgnoringCase(Heading.self, forKey: CodingKeys.heading)
            self.location = try container.decodeIfPresentIgnoringCase(Location.self, forKey: CodingKeys.location)
            self.accidentState = try container.decodeIfPresentIgnoringCase(BooleanState.self, forKey: CodingKeys.accidentState)
            self.vinDetails = try container.decodeIfPresentIgnoringCase(VinDetails.self, forKey: CodingKeys.vinDetails)
            self.towState = try container.decodeIfPresentIgnoringCase(BooleanState.self, forKey: CodingKeys.towState)
            self.parkedState = try container.decodeIfPresentIgnoringCase(BooleanState.self, forKey: CodingKeys.parkedState)
            self.ownerGroups = try container.decodeIfPresentIgnoringCase([String].self, forKey: CodingKeys.ownerGroups) ?? []
            self.tags = try container.decodeIfPresentIgnoringCase([String].self, forKey: CodingKeys.tags) ?? []
            self.deleted = try container.decodeIfPresentIgnoringCase(Bool.self, forKey: CodingKeys.deleted) ?? false
            self.createdOn = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.createdOn).flatMap { $0.dateFromISO }
            self.lastModified = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.lastModified).flatMap { $0.dateFromISO }
            self.engineOil = try container.decodeIfPresentIgnoringCase(EngineOil.self, forKey: CodingKeys.engineOil)
            self.tirePressure = try container.decodeIfPresentIgnoringCase(TirePressure.self, forKey: CodingKeys.tirePressure)
            self.predictiveMaintenance = try container.decodeIfPresentIgnoringCase(PredictiveMaintenance.self, forKey: CodingKeys.predictiveMaintenance)
            self.vehicleType = try container.decodeIfPresentIgnoringCase(VehicleType.self, forKey: CodingKeys.vehicleType)
            self.alternateId = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.alternateId)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.licensePlate, forKey: .licensePlate)
        try container.encodeIfPresent(self.vin, forKey: .vin)
        try container.encodeIfPresent(self.detectedVIN, forKey: .detectedVIN)
        try container.encodeIfPresent(self.overrideVIN, forKey: .overrideVIN)
        try container.encodeIfPresent(self.mojioId, forKey: .mojioId)
        try container.encodeIfPresent(self.compatDetails, forKey: .compatDetails)
        try container.encodeIfPresent(self.currentTrip, forKey: .currentTrip)
        try container.encodeIfPresent(self.milStatus, forKey: .milStatus)
        try container.encodeIfPresent(self.diagnosticCodes, forKey: .diagnosticCodes)
        try container.encodeIfPresent(self.lastContactTime, forKey: .lastContactTime)
        try container.encodeIfPresent(self.accelerometer, forKey: .accelerometer)
        try container.encodeIfPresent(self.acceleration, forKey: .acceleration)
        try container.encodeIfPresent(self.deceleration, forKey: .deceleration)
        
        try container.encodeIfPresent(self.speed, forKey: .speed)
        try container.encodeIfPresent(self.odometer, forKey: .odometer)
        try container.encodeIfPresent(self.virtualOdometer, forKey: .virtualOdometer)
        try container.encodeIfPresent(self.realOdometer, forKey: .realOdometer)
        try container.encodeIfPresent(self.rpm, forKey: .rpm)
        try container.encodeIfPresent(self.fuelEfficiency, forKey: .fuelEfficiency)
        try container.encodeIfPresent(self.fuelEfficiencyCalculationMethod, forKey: .fuelEfficiencyCalculationMethod)
        try container.encodeIfPresent(self.fuelLevel, forKey: .fuelLevel)
        try container.encodeIfPresent(self.fuelVolume, forKey: .fuelVolume)
        try container.encodeIfPresent(self.fuelType, forKey: .fuelType)
        try container.encodeIfPresent(self.gatewayTime, forKey: .gatewayTime)
        try container.encodeIfPresent(self.harshEventState, forKey: .harshEventState)
        try container.encodeIfPresent(self.idleState, forKey: .idleState)
        try container.encodeIfPresent(self.ignitionState, forKey: .ignitionState)
        try container.encodeIfPresent(self.battery, forKey: .battery)
        try container.encodeIfPresent(self.heading, forKey: .heading)
        try container.encodeIfPresent(self.location, forKey: .location)
        try container.encodeIfPresent(self.accidentState, forKey: .accidentState)
        try container.encodeIfPresent(self.vinDetails, forKey: .vinDetails)
        try container.encodeIfPresent(self.towState, forKey: .towState)
        try container.encodeIfPresent(self.parkedState, forKey: .parkedState)
        try container.encodeIfPresent(self.ownerGroups, forKey: .ownerGroups)
        try container.encodeIfPresent(self.tags, forKey: .tags)
        try container.encodeIfPresent(self.deleted, forKey: .deleted)
        try container.encodeIfPresent(self.createdOn, forKey: .createdOn)
        try container.encodeIfPresent(self.lastModified, forKey: .lastModified)
        try container.encodeIfPresent(self.engineOil, forKey: .engineOil)
        try container.encodeIfPresent(self.tirePressure, forKey: .tirePressure)
        try container.encodeIfPresent(self.predictiveMaintenance, forKey: .predictiveMaintenance)
        try container.encodeIfPresent(self.vehicleType, forKey: .vehicleType)
        try container.encodeIfPresent(self.alternateId, forKey: .alternateId)
    }
}

public func ==(lhs: Vehicle, rhs: Vehicle) -> Bool {
    return lhs.id == rhs.id
}

public struct VehicleUpdate: Codable {
    public var name: String?
    public var licensePlate: String?
    public var vin: String?
    public var odometer: OdometerUpdate?
    
    public enum CodingKeys: String, CodingKey {
        case name = "Name"
        case licensePlate = "LicensePlate"
        case vin = "VIN"
        case odometer = "Odometer"
    }
    
    public init(vehicle: Vehicle? = nil) {
        let odometer = vehicle?.odometer.map { OdometerUpdate(baseUnit: $0.baseUnit, baseValue: $0.baseValue, unit: $0.unit, value: $0.value, timestamp: $0.timestamp, rolloverValue: $0.rolloverValue) }
        self.init(
            name: vehicle?.name,
            licensePlate: vehicle?.licensePlate,
            vin: vehicle?.vin,
            odometer: odometer
        )
    }
    
    public init(
        name: String? = nil,
        licensePlate: String? = nil,
        vin: String? = nil,
        odometer: OdometerUpdate? = nil) {
        
        self.name = name
        self.licensePlate = licensePlate
        self.vin = vin
        self.odometer = odometer
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.licensePlate, forKey: .licensePlate)
        try container.encodeIfPresent(self.vin, forKey: .vin)
        try container.encodeIfPresent(self.odometer, forKey: .odometer)
    }
}
