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

enum VehicleAppearanceStyle: String, Codable {
    case sedan = "Sedan",
    hatchback = "Hatchback",
    smart = "Smart",
    mini = "Mini",
    convertable = "Convertible",
    suv = "Suv",
    truck = "Truck",
    van = "Van",
    deliveryTruck = "DeliveryTruck",
    sports = "Sports"
    
    static var defaultStyle: VehicleAppearanceStyle { return .sedan }
    
    static var all: [VehicleAppearanceStyle] {
        return [
            .sedan,
            .hatchback,
            .smart,
            .mini,
            .convertable,
            .sports,
            .suv,
            .truck,
            .van,
            .deliveryTruck
        ]
    }
    
    public init(from decoder: Decoder) throws {
        do { self = try VehicleAppearanceStyle.init(rawValue: decoder.singleValueContainer().decode(String.self)) ?? .sedan } catch { self = .sedan }
    }
}
