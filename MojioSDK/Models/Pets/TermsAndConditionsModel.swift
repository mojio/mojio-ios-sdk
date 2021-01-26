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

public struct TermsAndConditionsModel: Codable {
    public let acceptedOn: String
    public let acceptedEffectiveDate: String
    public let currentEffectiveDate: String
    public let isExpired: Bool
    
    public enum CodingKeys: String, CodingKey {
        case acceptedOn = "AcceptedOn"
        case acceptedEffectiveDate = "AcceptedEffectiveDate"
        case currentEffectiveDate = "CurrentEffectiveDate"
        case isExpired = "IsExpired"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.acceptedOn = try container.decode(String.self, forKey: .acceptedOn)
            self.acceptedEffectiveDate = try container.decode(String.self, forKey: .acceptedEffectiveDate)
            self.currentEffectiveDate = try container.decode(String.self, forKey: .currentEffectiveDate)
            self.isExpired = try container.decode(Bool.self, forKey: .isExpired)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}
