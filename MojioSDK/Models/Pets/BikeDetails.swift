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
}

public struct BikeDetails: BikeDetailsModel {
    
    public let serialNumber: String?
    
    public enum CodingKeys: String, CodingKey {
        case serialNumber = "SerialNumber"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.serialNumber = try container.decodeIfPresent(String.self, forKey: .serialNumber)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.serialNumber, forKey: .serialNumber)
    }
    
}

public struct BikeDetailsUpdate: Codable {

    public var serialNumber: String? = nil
    
    public enum CodingKeys: String, CodingKey {
        case serialNumber = "SerialNumber"
    }
    
    public init(bikeDetails: BikeDetails? = nil) {
        self.init(
            serialNumber: bikeDetails?.serialNumber
        )
    }
    
    public init(serialNumber: String? = nil) {
        self.serialNumber = serialNumber
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.serialNumber = try container.decodeIfPresent(String.self, forKey: .serialNumber)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
    
        try container.encodeIfPresent(self.serialNumber, forKey: .serialNumber)
    }
}
