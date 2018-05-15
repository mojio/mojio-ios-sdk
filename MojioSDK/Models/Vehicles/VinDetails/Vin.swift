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

public protocol VinModel: Codable {
    
    associatedtype E: EngineModel
    associatedtype T: TransmissionModel
    associatedtype W: WarrantyModel
    associatedtype R: RecallModel
    associatedtype S: ServiceBulletinModel
    
    var vin: String { get }
    var timestamp: Date? { get }
    var market: String? { get }
    var year: Int { get }
    var make: String? { get }
    var model: String? { get }
    var vehicleType: String? { get }
    var bodyType: String? { get }
    var driveType: String? { get }
    var fuelTankSize: Double { get }
    var epaFuelEfficiency: Double { get }
    var vehicleEngine: E? { get }
    var vehicleTransmission: T? { get }
    var warranties: [W] { get }
    var recalls: [R] { get }
    var serviceBulletins: [S] { get }
}

public struct Vin: VinModel {
    
    public typealias E = Engine
    public typealias T = Transmission
    public typealias W = Warranty
    public typealias R = Recall
    public typealias S = ServiceBulletin
    
    public let vin: String
    public let timestamp: Date?
    public let market: String?
    public let year: Int
    public let make: String?
    public let model: String?
    public let vehicleType: String?
    public let bodyType: String?
    public let driveType: String?
    public let fuelTankSize: Double
    public let epaFuelEfficiency: Double
    public let vehicleEngine: E?
    public let vehicleTransmission: T?
    public let warranties: [W]
    public let recalls: [R]
    public let serviceBulletins: [S]
    
    enum CodingKeys: String, CodingKey {
        case vin = "VIN"
        case timestamp = "Timestamp"
        case market = "Market"
        case year = "Year"
        case make = "Make"
        case model = "Model"
        case vehicleType = "VehicleType"
        case bodyType = "BodyType"
        case driveType = "DriveType"
        case fuelTankSize = "FuelTankSize"
        case epaFuelEfficiency = "EPAFuelEfficiency"
        case vehicleEngine = "Engine"
        case vehicleTransmission = "Transmission"
        case warranties = "Warranties"
        case recalls = "Recalls"
        case serviceBulletins = "ServiceBulletins"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.vin = try container.decodeIfPresent(String.self, forKey: .vin) ?? String.empty
            self.timestamp = try container.decodeIfPresent(String.self, forKey: .timestamp).flatMap { $0.dateFromIso8601 }
            
            self.market = try container.decodeIfPresent(String.self, forKey: .market)
            self.year = try container.decodeIfPresent(Int.self, forKey: .year) ?? 0
            self.make = try container.decodeIfPresent(String.self, forKey: .make)
            self.model = try container.decodeIfPresent(String.self, forKey: .model)
            
            self.vehicleType = try container.decodeIfPresent(String.self, forKey: .vehicleType)
            self.bodyType = try container.decodeIfPresent(String.self, forKey: .bodyType)
            self.driveType = try container.decodeIfPresent(String.self, forKey: .driveType)
            
            self.fuelTankSize = try container.decodeIfPresent(Double.self, forKey: .fuelTankSize) ?? 0
            self.epaFuelEfficiency = try container.decodeIfPresent(Double.self, forKey: .epaFuelEfficiency) ?? 0
            
            self.vehicleEngine = try container.decodeIfPresent(Engine.self, forKey: .vehicleEngine)
            
            self.vehicleTransmission = try container.decodeIfPresent(Transmission.self, forKey: .vehicleTransmission)
            
            self.warranties = try container.decodeIfPresent([Warranty].self, forKey: .warranties) ?? []
            
            self.recalls = try container.decodeIfPresent([Recall].self, forKey: .recalls) ?? []
            
            self.serviceBulletins = try container.decodeIfPresent([ServiceBulletin].self, forKey: .serviceBulletins) ?? []
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}

extension Vin: PrimaryKey {
    public var id: String {
        return self.vin
    }
}
