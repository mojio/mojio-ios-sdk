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

public protocol TripPropertiesModel: Codable {
    associatedtype D: TripPropertiesDetailsModel
    
    var details: D? { get }
}


public protocol TripPropertiesDetailsModel: Codable {
    var purpose: String? { get }
    var notes: String? { get }
}

public struct TripPropertiesDetails: TripPropertiesDetailsModel {
    
    public let purpose: String?
    public let notes: String?

    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case purpose = "purpose"
        case notes = "notes"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)

            self.purpose = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.purpose)
            self.notes = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.notes)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(self.purpose, forKey: .purpose)
        try container.encodeIfPresent(self.notes, forKey: .notes)
    }
}

public struct TripProperties: TripPropertiesModel {
    public typealias D = TripPropertiesDetails
    
    public let details: D?
    
    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case details = "details"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)

            self.details = try container.decodeIfPresentIgnoringCase(D.self, forKey: CodingKeys.details)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(self.details, forKey: .details)
    }
}
