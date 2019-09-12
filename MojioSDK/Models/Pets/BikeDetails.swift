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

public protocol BikeDetailsModel: Codable {
    var serialNumber: String? { get }
    var color: String? { get }
    var style: String? { get }
}

public struct BikeDetails: BikeDetailsModel {
    
    public let serialNumber: String?
    public let color: String?
    public let style: String?
    
    public enum CodingKeys: String, CodingKey {
        case serialNumber = "SerialNumber"
        case color = "Color"
        case style = "Style"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.serialNumber = try container.decodeIfPresent(String.self, forKey: .serialNumber)
            self.color = try container.decodeIfPresent(String.self, forKey: .color)
            self.style = try container.decodeIfPresent(String.self, forKey: .style)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.serialNumber, forKey: .serialNumber)
        try container.encodeIfPresent(self.color, forKey: .color)
        try container.encodeIfPresent(self.style, forKey: .style)
    }
    
}

public struct BikeDetailsUpdate: Codable {
    
    public var serialNumber: String? = nil
    public var color: String? = nil
    public var style: String? = nil
    
    public enum CodingKeys: String, CodingKey {
        case serialNumber = "SerialNumber"
        case color = "Color"
        case style = "Style"
    }
    
    public init(bikeDetails: BikeDetails? = nil) {
        self.init(
            serialNumber: bikeDetails?.serialNumber,
            color: bikeDetails?.color,
            style: bikeDetails?.style
        )
    }
    
    public init(serialNumber: String? = nil, color: String? = nil, style: String? = nil) {
        self.serialNumber = serialNumber
        self.color = color
        self.style = style
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.serialNumber = try container.decodeIfPresent(String.self, forKey: .serialNumber)
            self.color = try container.decodeIfPresent(String.self, forKey: .color)
            self.style = try container.decodeIfPresent(String.self, forKey: .style)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.serialNumber, forKey: .serialNumber)
        try container.encodeIfPresent(self.color, forKey: .color)
        try container.encodeIfPresent(self.style, forKey: .style)
    }
}
