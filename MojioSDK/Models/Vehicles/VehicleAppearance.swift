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

public protocol VehicleAppearanceModel: Codable, PrimaryKey {
    var vehicleId: String { get }
    var color: EntityAppearanceColor? { get }
    var icon: VehicleAppearanceStyle? { get }
    var showOnMap: Bool? { get }
}

public struct VehicleAppearance: VehicleAppearanceModel {
    
    public let vehicleId: String
    public let color: EntityAppearanceColor?
    public let icon: VehicleAppearanceStyle?
    public let showOnMap: Bool?
    
    public enum CodingKeys: String, CodingKey {
        case vehicleId = "VehicleId"
        case color = "Color"
        case icon = "Icon"
        case showOnMap = "ShowOnMap"
    }
    
    public static func defaultAppearence(id: String, showOnMap: Bool = false) -> VehicleAppearance {
        return VehicleAppearance(
            vehicleId: id,
            color: .default,
            icon: VehicleAppearanceStyle.defaultStyle,
            showOnMap: showOnMap)
    }
    
    public var id: String {
        return vehicleId
    }
}

public extension VehicleAppearance {
    public static func == (lhs: VehicleAppearance, rhs: VehicleAppearance) -> Bool {
        return lhs.vehicleId == rhs.vehicleId
    }
}

public protocol VehicleAppearanceCollectionModel: Codable {
    
    associatedtype AppearanceType: VehicleAppearanceModel
    
    var appearances: [AppearanceType]? { get }
}

public struct VehicleAppearanceCollection: VehicleAppearanceCollectionModel {
    
    public typealias AppearanceType = VehicleAppearance
    
    public let appearances: [VehicleAppearance]?
    
    public enum CodingKeys: String, CodingKey {
        case appearances = "Data"
    }
}
