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

public struct VehicleAppearance: Codable {
    
    public var vehicleId: String = String.empty
    public var color: String?
    public var icon: String?
    public var showOnMap: Bool?
    
    public enum CodingKeys: String, CodingKey {
        case vehicleId = "VehicleId"
        case color = "Color"
        case icon = "Icon"
        case showOnMap = "ShowOnMap"
    }
    
    public init() {}
    
    public init(vehicleId: String, color: String?, icon: String?, showOnMap: Bool?) {
        
        self.vehicleId = vehicleId
        self.color = color
        self.icon = icon
        self.showOnMap = showOnMap
    }
    
    public var Id: String? {
        get {
            return vehicleId
        }
        set {
            vehicleId = newValue ?? String.empty
        }
    }
}

extension VehicleAppearance: Equatable {
    public static func == (lhs: VehicleAppearance, rhs: VehicleAppearance) -> Bool {
        return lhs.vehicleId == rhs.vehicleId && lhs.color == rhs.color &&
            lhs.icon == rhs.icon && lhs.showOnMap == rhs.showOnMap
    }
}


public struct VehicleAppearanceStorageData: Codable {
    
    public var vehicleAppearances: [VehicleAppearance]?
    
    public enum CodingKeys: String, CodingKey {
        case vehicleAppearances = "Data"
    }
    
    public init(vehicleAppearances: [VehicleAppearance]?) {
        self.vehicleAppearances = vehicleAppearances
    }
}
