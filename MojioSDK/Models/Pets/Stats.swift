/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2018 Copyright Moj.io Inc.
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
import CoreLocation

public protocol GeneralStats {
    var id: String? { get }
    var date: Date? { get }
    var steps: Int? { get }
    var activeMinutes: Int? { get }
}

public struct Stats: Codable, GeneralStats {
    public let id: String?
    public let date: Date?
    public let steps: Int?
    public let activeMinutes: Int?
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case date = "Date"
        case steps = "Steps"
        case activeMinutes = "ActiveMinutes"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.id = try container.decodeIfPresent(String.self, forKey: .id)
            
            if let steps = try container.decodeIfPresent(Double.self, forKey: .steps) {
                self.steps = Int(steps)
            }
            else {
                self.steps = nil
            }
            
            self.activeMinutes = try container.decodeIfPresent(Int.self, forKey: .activeMinutes)
            self.date = try container.decodeIfPresent(String.self, forKey: .date).flatMap { $0.dateFromIso8601 }
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

public func ==(lhs: Stats, rhs: Stats) -> Bool {
    return lhs.id == rhs.id
}

