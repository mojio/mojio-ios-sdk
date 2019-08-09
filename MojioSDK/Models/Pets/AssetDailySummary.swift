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
    var date: Date? { get }
    var steps: Int? { get }
    var activeMinutes: Int? { get }
    var encodedPolyline: String? { get }
    var distance: Double? { get }
    var isPiiRemoved: Bool { get }
}

public struct AssetDailySummary: AssetDailySummaryModel {
    public let id: String
    public let assetId: String
    public let date: Date?
    public let steps: Int?
    public let activeMinutes: Int?
    public let encodedPolyline: String?
    public let distance: Double?
    public let isPiiRemoved: Bool
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case assetId = "AssetId"
        case date = "Date"
        case steps = "Steps"
        case activeMinutes = "ActiveMinutes"
        case encodedPolyline = "EncodedPolyline"
        case distance = "Distance"
        case isPiiRemoved = "IsPiiRemoved"
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
            /// PHIOS-1123: Trim time+timezone from the string and properly convert it to the date
            self.date = try container.decodeIfPresent(String.self, forKey: .date)
//                .flatMap { String($0.prefix(while: { $0 != "T" })) }
                .flatMap { $0.toDate }
            self.encodedPolyline = try container.decodeIfPresent(String.self, forKey: .encodedPolyline)
            self.distance = try container.decodeIfPresent(Double.self, forKey: .distance)
            self.isPiiRemoved = try container.decode(Bool.self, forKey: .isPiiRemoved)
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

