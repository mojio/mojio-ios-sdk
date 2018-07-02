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

public protocol AssetDailySummaryModel: Codable {
    var id: String { get }
    var assetId: String { get }
    var lastModified: Date? { get }
    var steps: Int? { get }
    var activeMinutes: Int? { get }
    var encodedPolyline: String? { get }
}

public struct AssetDailySummary: AssetDailySummaryModel {
    public let id: String
    public let assetId: String
    public let lastModified: Date?
    public let steps: Int?
    public let activeMinutes: Int?
    public let encodedPolyline: String?
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case assetId = "AssetId"
        case lastModified = "LastModified"
        case steps = "Steps"
        case activeMinutes = "ActiveMinutes"
        case encodedPolyline = "EncodedPolyline"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.id = try container.decode(String.self, forKey: .id)
            self.assetId = try container.decode(String.self, forKey: .assetId)
            
            if let steps = try container.decodeIfPresent(Double.self, forKey: .steps) {
                self.steps = Int(steps)
            }
            else {
                self.steps = nil
            }
            
            self.activeMinutes = try container.decodeIfPresent(Int.self, forKey: .activeMinutes)
            self.lastModified = try container.decodeIfPresent(String.self, forKey: .lastModified).flatMap { $0.dateFromIso8601 }
            self.encodedPolyline = try container.decodeIfPresent(String.self, forKey: .encodedPolyline)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

public func ==(lhs: AssetDailySummaryModel, rhs: AssetDailySummaryModel) -> Bool {
    return lhs.id == rhs.id
}

