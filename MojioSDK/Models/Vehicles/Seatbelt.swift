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
import MojioCore

public enum SeatOccupiedStatus: String, Codable, Equatable {
    case unoccupied = "Unoccupied"
    case occupied = "Occupied"
    case unknown = "Unknown"

    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = SeatOccupiedStatus(rawValue: label) ?? .unknown
    }
}

public protocol SeatsModel: Codable {
    
    var timestamp: Date? { get }
    var driverSeatOccupiedStatus: SeatOccupiedStatus? { get }
    var passengerSeatOccupiedStatus: SeatOccupiedStatus? { get }
}

public struct Seats: SeatsModel {
    
    public var timestamp: Date? = nil
    public var driverSeatOccupiedStatus: SeatOccupiedStatus? = nil
    public var passengerSeatOccupiedStatus: SeatOccupiedStatus? = nil

    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case timestamp = "Timestamp"
        case driverSeatOccupiedStatus = "DriverSeatOccupiedStatus"
        case passengerSeatOccupiedStatus = "PassengerSeatOccupiedStatus"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            
            self.timestamp = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.timestamp).flatMap { $0.dateFromISO }
            self.driverSeatOccupiedStatus = try container.decodeIfPresentIgnoringCase(SeatOccupiedStatus.self, forKey: CodingKeys.driverSeatOccupiedStatus)
            self.passengerSeatOccupiedStatus = try container.decodeIfPresentIgnoringCase(SeatOccupiedStatus.self, forKey: CodingKeys.passengerSeatOccupiedStatus)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.timestamp, forKey: .timestamp)
        try container.encodeIfPresent(self.driverSeatOccupiedStatus, forKey: .driverSeatOccupiedStatus)
        try container.encodeIfPresent(self.passengerSeatOccupiedStatus, forKey: .passengerSeatOccupiedStatus)
    }
}
