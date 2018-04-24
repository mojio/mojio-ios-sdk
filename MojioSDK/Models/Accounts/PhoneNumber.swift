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

struct PhoneNumber: Codable {
    let phoneNumber: String?
    let verified: Bool?
    
    enum CodingKeys: String, CodingKey {
        case phoneNumber = "PhoneNumber"
        case verified = "Verified"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber)
            self.verified = try container.decodeIfPresent(Bool.self, forKey: .verified)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

struct PhoneUpdate: Codable {
    var phoneNumber: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case phoneNumber = "PhoneNumber"
    }
    
    init(phoneNumber: PhoneNumber? = nil) {
        self.phoneNumber = phoneNumber?.phoneNumber
    }
    
    init(phoneNumber: String? = nil) {
        self.phoneNumber = phoneNumber
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.phoneNumber, forKey: .phoneNumber)
    }
}
