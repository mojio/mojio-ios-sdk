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

public protocol WarningStateModel: Codable {
    var timestamp: Date? { get }
    var warning: Bool { get }
}

public struct WarningState: WarningStateModel {
    public let timestamp: Date?
    public let warning: Bool
    
    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case timestamp = "Timestamp"
        case warning = "Warning"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            
            self.timestamp = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.timestamp).flatMap { $0.dateFromISO }
            self.warning = try container.decodeIgnoringCase(Bool.self, forKey: CodingKeys.warning)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.warning, forKey: .warning)
        try container.encodeIfPresent(self.timestamp, forKey: .timestamp)
    }
}

public protocol PredictiveMaintenanceModel: Codable {
    associatedtype WS: WarningStateModel
    var battery: WS? { get }
    var airFilter: WS? { get }
}

public struct PredictiveMaintenance: PredictiveMaintenanceModel {
    public typealias WS = WarningState
    public var battery: WS?
    public var airFilter: WS?
    
    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case battery = "Battery"
        case airFilter = "AirFilter"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            
            self.battery = try container.decodeIfPresentIgnoringCase(WS.self, forKey: CodingKeys.battery)
            self.airFilter = try container.decodeIfPresentIgnoringCase(WS.self, forKey: CodingKeys.airFilter)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.battery, forKey: .battery)
        try container.encodeIfPresent(self.airFilter, forKey: .airFilter)
    }
}
