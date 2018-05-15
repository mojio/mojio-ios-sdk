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

public protocol GeneralVinDetails {
    
    associatedtype F: GeneralFuelCapacity
    
    var timestamp: Date? { get }
    var vin: String? { get }
    var year: Int { get }
    var make: String? { get }
    var model: String? { get }
    var engine: String? { get }
    var cylinders: Int? { get }
    var totalFuelCapacity: F? { get }
    var fuelType: String? { get }
    var cityFuelEfficiency: Double { get }
    var highwayFuelEfficiency: Double { get }
    var combinedFuelEfficiency: Double { get }
    var transmission: String? { get }
    var message: String? { get }
    var success: Bool? { get }
}

public struct VinDetails: Codable, GeneralVinDetails {
    
    public typealias F = FuelCapacity
    
    public let timestamp: Date?
    public let vin: String?
    public let year: Int
    public let make: String?
    public let model: String?
    public let engine: String?
    public let cylinders: Int?
    public let totalFuelCapacity: F?
    public let fuelType: String?
    public let cityFuelEfficiency: Double
    public let highwayFuelEfficiency: Double
    public let combinedFuelEfficiency: Double
    public let transmission: String?
    public let message: String?
    public let success: Bool?
    
    enum CodingKeys: String, CodingKey {
        case timestamp = "Timestamp"
        case vin = "Vin"
        case year = "Year"
        case make = "Make"
        case model = "Model"
        case engine = "Engine"
        case cylinders = "Cylinders"
        case totalFuelCapacity = "TotalFuelCapacity"
        case fuelType = "FuelType"
        case cityFuelEfficiency = "CityFuelEfficiency"
        case highwayFuelEfficiency = "HighwayFuelEfficiency"
        case combinedFuelEfficiency = "CombinedFuelEfficiency"
        case transmission = "Transmission"
        case message = "Message"
        case success = "Success"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.timestamp = try container.decodeIfPresent(String.self, forKey: .timestamp).flatMap { $0.dateFromIso8601 }
            
            self.vin = try container.decodeIfPresent(String.self, forKey: .vin)
            self.year = try container.decodeIfPresent(Int.self, forKey: .year) ?? 0
            self.make = try container.decodeIfPresent(String.self, forKey: .make)
            self.model = try container.decodeIfPresent(String.self, forKey: .model)
            
            self.engine = try container.decodeIfPresent(String.self, forKey: .engine)
            self.cylinders = try container.decodeIfPresent(Int.self, forKey: .cylinders)
            self.totalFuelCapacity = try container.decodeIfPresent(FuelCapacity.self, forKey: .totalFuelCapacity)
            
            self.fuelType = try container.decodeIfPresent(String.self, forKey: .fuelType)
            
            self.cityFuelEfficiency = try container.decodeIfPresent(Double.self, forKey: .cityFuelEfficiency) ?? 0
            
            self.highwayFuelEfficiency = try container.decodeIfPresent(Double.self, forKey: .highwayFuelEfficiency) ?? 0
            
            self.combinedFuelEfficiency = try container.decodeIfPresent(Double.self, forKey: .combinedFuelEfficiency) ?? 0
            
            self.transmission = try container.decodeIfPresent(String.self, forKey: .transmission)
            
            self.message = try container.decodeIfPresent(String.self, forKey: .message)
            
            self.success = try container.decodeIfPresent(Bool.self, forKey: .success) ?? false
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
