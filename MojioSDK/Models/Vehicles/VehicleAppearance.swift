/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2019 Copyright Moj.io Inc.
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
    public var vehicleImage: VehicleImage?
    
    public struct VehicleImage: Codable {
        public let url: String
        public let hexColor: String
        public let year: String?
        public let model: String?
        public let make: String?
        
        public init(url: String, hexColor: String, year: String?, model: String?, make: String?) {
            self.url = url
            self.hexColor = hexColor
            self.year = year
            self.model = model
            self.make = make
        }
    }
    
    public enum CodingKeys: String, CodingKey {
        case vehicleId = "VehicleId"
        case vehicleImage = "VehicleImage"
    }
    
    public init() {}
    
    public init(vehicleId: String) {
        
        self.vehicleId = vehicleId
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
        return lhs.vehicleId == rhs.vehicleId && lhs.vehicleImage == rhs.vehicleImage
    }
}

extension VehicleAppearance.VehicleImage: Equatable {
    public static func ==(lhs: VehicleAppearance.VehicleImage, rhs: VehicleAppearance.VehicleImage) -> Bool {
        return lhs.url == rhs.url && lhs.hexColor == rhs.hexColor && lhs.year == rhs.year && lhs.make == rhs.make && lhs.model == rhs.model
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
