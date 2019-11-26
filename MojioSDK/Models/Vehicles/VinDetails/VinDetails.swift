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

public protocol VinDetailsModel: Codable {
    
    associatedtype F: FuelCapacityModel
    
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

public struct VinDetails: VinDetailsModel {
    
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
            
            self.timestamp = try container.decodeIfPresentIgnoringCase(String.self, forKey: .timestamp).flatMap { $0.dateFromISO }
            
            self.vin = try container.decodeIfPresentIgnoringCase(String.self, forKey: .vin)
            self.year = try container.decodeIfPresentIgnoringCase(Int.self, forKey: .year) ?? 0
            self.make = try container.decodeIfPresentIgnoringCase(String.self, forKey: .make)
            self.model = try container.decodeIfPresentIgnoringCase(String.self, forKey: .model)
            
            self.engine = try container.decodeIfPresentIgnoringCase(String.self, forKey: .engine)
            self.cylinders = try container.decodeIfPresentIgnoringCase(Int.self, forKey: .cylinders)
            self.totalFuelCapacity = try container.decodeIfPresentIgnoringCase(FuelCapacity.self, forKey: .totalFuelCapacity)
            
            self.fuelType = try container.decodeIfPresentIgnoringCase(String.self, forKey: .fuelType)
            
            self.cityFuelEfficiency = try container.decodeIfPresentIgnoringCase(Double.self, forKey: .cityFuelEfficiency) ?? 0
            
            self.highwayFuelEfficiency = try container.decodeIfPresentIgnoringCase(Double.self, forKey: .highwayFuelEfficiency) ?? 0
            
            self.combinedFuelEfficiency = try container.decodeIfPresentIgnoringCase(Double.self, forKey: .combinedFuelEfficiency) ?? 0
            
            self.transmission = try container.decodeIfPresentIgnoringCase(String.self, forKey: .transmission)
            
            self.message = try container.decodeIfPresentIgnoringCase(String.self, forKey: .message)
            
            self.success = try container.decodeIfPresentIgnoringCase(Bool.self, forKey: .success) ?? false
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.timestamp, forKey: .timestamp)
        
        try container.encodeIfPresent(self.vin, forKey: .vin)
        try container.encodeIfPresent(self.year, forKey: .year)
        try container.encodeIfPresent(self.make, forKey: .make)
        try container.encodeIfPresent(self.model, forKey: .model)
        
        try container.encodeIfPresent(self.engine, forKey: .engine)
        try container.encodeIfPresent(self.cylinders, forKey: .cylinders)
        try container.encodeIfPresent(self.totalFuelCapacity, forKey: .totalFuelCapacity)
        
        try container.encodeIfPresent(self.fuelType, forKey: .fuelType)
        
        try container.encodeIfPresent(self.cityFuelEfficiency, forKey: .cityFuelEfficiency)
        
        try container.encodeIfPresent(self.highwayFuelEfficiency, forKey: .highwayFuelEfficiency)
        
        try container.encodeIfPresent(self.combinedFuelEfficiency, forKey: .combinedFuelEfficiency)
        
        try container.encodeIfPresent(self.transmission, forKey: .transmission)
        
        try container.encodeIfPresent(self.message, forKey: .message)
        
        try container.encodeIfPresent(self.success, forKey: .success)
    }
}
