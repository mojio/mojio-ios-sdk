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

public protocol VehicleImageType: Codable {
    var src: String { get }
    var normal: String { get }
    var thumbnail: String { get }
}

public struct VehicleImage: VehicleImageType {
    public var src: String
    public var normal: String
    public var thumbnail: String
    
    public enum CodingKeys: String, CodingKey {
        case src = "Src"
        case normal = "Normal"
        case thumbnail = "Thumbnail"
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
    associatedtype I: VehicleImageType
    
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
    var image: I? { get }
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
    public typealias I = VehicleImage
    
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
    public var image: I?
    
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
        case image = "Image"
    }
}

public func ==(lhs: Vehicle, rhs: Vehicle) -> Bool {
    return lhs.id == rhs.id
}
