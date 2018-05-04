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

public struct VehicleStatistics: Codable {
    
    public let estimatedFuelLevel: FuelLevel?
    public let estimatedFuelVolume: FuelVolume?
    public let averageFuelEfficiency: FuelEfficiency?
    public let totalRange: Distance?
    public let currentRange: Distance?
    public let lastFillUpDate: Date?
    
    public enum CodingKeys: String, CodingKey {
        case estimatedFuelLevel = "EstimatedFuelLevel"
        case estimatedFuelVolume = "EstimatedFuelVolume"
        case averageFuelEfficiency = "AverageFuelEfficiency"
        case totalRange = "TotalRange"
        case currentRange = "CurrentRange"
        case lastFillUpDate = "LastFillUpDate"
    }
}
