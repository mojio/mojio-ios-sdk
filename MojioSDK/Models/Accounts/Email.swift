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

public protocol EmailModel: Codable {
    var verified: Bool? { get }
    var address: String? { get }
}

public struct Email: EmailModel {
    public let verified: Bool?
    public let address: String?
    
    public enum CodingKeys: String, CodingKey {
        case verified = "Verified"
        case address = "Address"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.verified = try container.decodeIfPresent(Bool.self, forKey: .verified)
            self.address = try container.decodeIfPresent(String.self, forKey: .address)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}
