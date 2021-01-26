/******************************************************************************
* Moj.io Inc. CONFIDENTIAL
* 2021 Copyright Moj.io Inc.
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

public enum VehicleAppearanceStyle: String, Codable {

    // Note: values should be compatible with Android's version
    case sedan = "Sedan"
    case hatchback = "Hatchback"
    case smart = "Smart car"
    case mini = "Mini"
    case convertible = "Convertible"
    case sports = "Sports car"
    case wagon = "Wagon"
    case pickup = "Pickup"
    case van = "Full-size van"
    case boxTruck = "Box truck"
    case suv = "Suv"

    public static var defaultStyle: VehicleAppearanceStyle { return .sedan }

    public static var all: [VehicleAppearanceStyle] {
        return [
            .sedan, .hatchback, .smart, .mini, .convertible,
            .sports, .wagon, .pickup, .van, .boxTruck, .suv
        ]
    }

    public init(from decoder: Decoder) throws {
        
        let oldStylesDecoder = [
             "Smart": "Smart car",
             "Sports": "Sports car",
             "Truck": "Pickup",
             "Van": "Full-size van",
             "DeliveryTruck": "Box truck"
        ]
        
        let updateToNewStyle: (String) -> String = { styleValue in
            if let newStyleValue = oldStylesDecoder[styleValue] {
                return newStyleValue
            }
            
            return styleValue
        }

        do {
            let styleValue = try updateToNewStyle(decoder.singleValueContainer().decode(String.self))
            self = VehicleAppearanceStyle.init(rawValue: styleValue) ?? VehicleAppearanceStyle.defaultStyle
        }
        catch {
            self = VehicleAppearanceStyle.defaultStyle
        }
    }
}
