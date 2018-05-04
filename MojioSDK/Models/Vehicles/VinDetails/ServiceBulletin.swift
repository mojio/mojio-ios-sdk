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

public struct ServiceBulletin: Codable {
    
    public let itemNumber: String?
    public let bulletinNumber: String?
    public let replacementBulletinNumber: String?
    public let dateAdded: Date?
    public let component: String?
    public let bulletinDate: Date?
    public let summary: String?

    public enum CodingKeys: String, CodingKey {
        case itemNumber = "ItemNumber"
        case bulletinNumber = "BulletinNumber"
        case replacementBulletinNumber = "ReplacementBulletinNumber"
        case dateAdded = "DateAdded"
        case component = "Component"
        case bulletinDate = "BulletinDate"
        case summary = "Summary"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.itemNumber = try container.decodeIfPresent(String.self, forKey: .itemNumber)
            self.bulletinNumber = try container.decodeIfPresent(String.self, forKey: .bulletinNumber)
            self.replacementBulletinNumber = try container.decodeIfPresent(String.self, forKey: .replacementBulletinNumber)
            self.dateAdded = try container.decodeIfPresent(String.self, forKey: .dateAdded).flatMap { $0.dateFromIso8601 }
            self.component = try container.decodeIfPresent(String.self, forKey: .component)
            self.bulletinDate = try container.decodeIfPresent(String.self, forKey: .bulletinDate).flatMap { $0.dateFromIso8601 }
            self.summary = try container.decodeIfPresent(String.self, forKey: .summary)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
