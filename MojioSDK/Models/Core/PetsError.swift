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

protocol BaseError: Swift.Error {
    var code: String? {get}
    var message: String? {get}
}

protocol ErrorList: BaseError {
    var errors: [ApiError]? { get }
}

struct ApiErrorAditional: Codable {
    let deviceId: String?
}

struct ApiError: ErrorList, Codable {
    let code: String?
    let errors: [ApiError]?
    let message: String?
    let additional: ApiErrorAditional?
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case message = "Message"
        case errors = "Errors"
        case additional = "Additional"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.errors = try container.decodeIfPresent([ApiError].self, forKey: .errors)
        self.additional = try container.decodeIfPresent(ApiErrorAditional.self, forKey: .additional)
    }
}
