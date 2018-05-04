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

public struct Engine: Codable {
    
    public let name: String?
    public let cylinders: String?
    public let displacement: Double
    public let fuelInduction: String?
    public let fuelQuality: String?
    public let fuelType: String?
    public let maxHp: String?
    public let maxHpAt: String?
    
    public enum CodingKeys: String, CodingKey {
        case name = "Name"
        case cylinders = "Cylinders"
        case displacement = "Displacement"
        case fuelInduction = "FuelInduction"
        case fuelQuality = "FuelQuality"
        case fuelType = "FuelType"
        case maxHp = "MaxHp"
        case maxHpAt = "MaxHpAt"
    }
}
