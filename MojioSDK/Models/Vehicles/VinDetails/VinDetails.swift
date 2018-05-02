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

public struct VinDetails: Codable {
    
    public let timestamp: Date?
    public let vin: String?
    public let year: Int
    public let make: String?
    public let model: String?
    public let engine: String?
    public let cylinders: Int?
    public let totalFuelCapacity: FuelCapacity?
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
}
