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

public protocol SeatbeltModel: Codable {
    
    var timestamp: Date? { get }
    var seatbeltStatusDriver: Bool? { get }
    var seatbeltStatusPassenger: Bool? { get }
    var seatbeltStatusWarning: Bool? { get }
}

public struct Seatbelt: SeatbeltModel {
    
    public var timestamp: Date? = nil
    public var seatbeltStatusDriver: Bool? = nil
    public var seatbeltStatusPassenger: Bool? = nil
    public var seatbeltStatusWarning: Bool? = nil

    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case timestamp = "Timestamp"
        case seatbeltStatusDriver = "SeatbeltStatusDriver"
        case seatbeltStatusPassenger = "SeatbeltStatusPassenger"
        case seatbeltStatusWarning = "SeatbeltStatusWarning"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            
            self.timestamp = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.timestamp).flatMap { $0.dateFromISO }
            self.seatbeltStatusDriver = try container.decodeIfPresentIgnoringCase(Bool.self, forKey: CodingKeys.seatbeltStatusDriver)
            self.seatbeltStatusPassenger = try container.decodeIfPresentIgnoringCase(Bool.self, forKey: CodingKeys.seatbeltStatusPassenger)
            self.seatbeltStatusWarning = try container.decodeIfPresentIgnoringCase(Bool.self, forKey: CodingKeys.seatbeltStatusWarning)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.timestamp, forKey: .timestamp)
        try container.encodeIfPresent(self.seatbeltStatusDriver, forKey: .seatbeltStatusDriver)
        try container.encodeIfPresent(self.seatbeltStatusPassenger, forKey: .seatbeltStatusPassenger)
        try container.encodeIfPresent(self.seatbeltStatusWarning, forKey: .seatbeltStatusWarning)
    }
}
