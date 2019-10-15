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



public struct TirePressureStatus: Codable {
    
    public var timestamp: Date?
    public var value: String?
    
    public enum CodingKeys: String, CodingKey {
        case timestamp = "_ts"
        case value = "val"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            self.timestamp = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.timestamp).flatMap { $0.dateFromISO }
            self.value = try container.decodeIfPresentIgnoringCase(Bool.self, forKey: CodingKeys.value)
            
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.timestamp, forKey: .timestamp)
        try container.encodeIfPresent(self.value, forKey: .value)
    }
}



public protocol TirePressureModel: Codable {
    
    var timestamp: Date? { get }
    var tirePressureWarning: Bool? { get }
    var pressureLowWarning: Bool? { get }
    var RFTirePressureStatus: TirePressureStatus? { get }
    var RRTirePressureStatus: TirePressureStatus? { get }
    var RROTirePresssureStatus: TirePressureStatus? { get }
    var LFTirePressureStatus: TirePressureStatus? { get }
    var LRTirePressureStatus: TirePressureStatus? { get }
    var LROTirePressureStatus: TirePressureStatus? { get }
}



public struct TirePressure: TirePressureModel {
    
    public var timestamp: Date?
    public var tirePressureWarning: Bool?
    public var RFTirePressureStatus: TirePressureStatus? // Right, front tire
    public var RRTirePressureStatus: TirePressureStatus? // Right, rear tire
    public var RROTirePresssureStatus: TirePressureStatus? // Right, rear, outer tire
    public var LFTirePressureStatus: TirePressureStatus? // Left, front tire
    public var LRTirePressureStatus: TirePressureStatus? // Left, rear tire
    public var LROTirePressureStatus: TirePressureStatus? // Left, rear, outer tire
    
    
    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case timestamp = "Timestamp"
        case tirePressureWarning = "TirePressureWarning"
        case RFTirePressureStatus = "RightFrontTirePressureStatus"
        case RRTirePressureStatus = "RightRearTirePressureStatus"
        case RROTirePresssureStatus = "RightRearOuterTirePressureStatus"
        case LFTirePressureStatus = "LeftFrontTirePressureStatus"
        case LRTirePressureStatus = "LeftRearTirePressureStatus"
        case LROTirePressureStatus = "LeftRearOuterTirePressureStatus"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            
            self.timestamp = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.timestamp).flatMap { $0.dateFromISO }
            self.tirePressureWarning = try container.decodeIfPresentIgnoringCase(Bool.self, forKey: CodingKeys.tirePressureWarning)
            self.RFTirePressureStatus = try container.decodeIfPresentIgnoringCase(Bool.TirePressureStatus, forKey: CodingKeys.RFTirePressureStatus)
            self.RRTirePressureStatus = try container.decodeIfPresentIgnoringCase(Bool.TirePressureStatus, forKey: CodingKeys.RRTirePressureStatus)
            self.RROTirePresssureStatus = try container.decodeIfPresentIgnoringCase(Bool.TirePressureStatus, forKey: CodingKeys.RROTirePresssureStatus)
            self.LFTirePressureStatus = try container.decodeIfPresentIgnoringCase(Bool.TirePressureStatus, forKey: CodingKeys.LFTirePressureStatus)
            self.LRTirePressureStatus = try container.decodeIfPresentIgnoringCase(Bool.TirePressureStatus, forKey: CodingKeys.LRTirePressureStatus)
            self.LROTirePressureStatus = try container.decodeIfPresentIgnoringCase(Bool.TirePressureStatus, forKey: CodingKeys.LROTirePressureStatus)
            
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.timestamp, forKey: .timestamp)
        try container.encodeIfPresent(self.tirePressureWarning, forKey: .tirePressureWarning)
        try container.encodeIfPresent(self.RFTirePressureStatus, forKey: .RFTirePressureStatus)
        try container.encodeIfPresent(self.RRTirePressureStatus, forKey: .RRTirePressureStatus)
        try container.encodeIfPresent(self.RROTirePresssureStatus, forKey: .RROTirePresssureStatus)
        try container.encodeIfPresent(self.LFTirePressureStatus, forKey: .LFTirePressureStatus)
        try container.encodeIfPresent(self.LRTirePressureStatus, forKey: .LRTirePressureStatus)
        try container.encodeIfPresent(self.LROTirePressureStatus, forKey: .LROTirePressureStatus)
    }
}





