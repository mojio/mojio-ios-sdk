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

public protocol CompletedMaintenanceModel: Codable {
    
    associatedtype O: OdometerModel
    
    var id: String { get }
    var vehicleId: String { get }
    var completedDate: Date? { get }
    var completedOdometer: O? { get }
}

public struct CompletedMaintenance: CompletedMaintenanceModel {
    
    public typealias O = Odometer
    
    public var id: String
    public var vehicleId: String
    public var completedDate: Date?
    public var completedOdometer: O?

    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case id = "Id"
        case vehicleId = "VehicleId"
        case completedDate = "CompletedDate"
        case completedOdometer = "CompletedOdometer"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            
            self.id = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.id) ?? .empty
            self.vehicleId = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.vehicleId) ?? .empty
            self.completedOdometer = try container.decodeIfPresentIgnoringCase(O.self, forKey: CodingKeys.completedOdometer)
            self.completedDate = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.completedDate).flatMap { $0.dateFromISO }
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encodeIfPresent(self.vehicleId, forKey: .vehicleId)
        try container.encodeIfPresent(self.completedDate, forKey: .completedDate)
        try container.encodeIfPresent(self.completedOdometer, forKey: .completedOdometer)
    }
}

