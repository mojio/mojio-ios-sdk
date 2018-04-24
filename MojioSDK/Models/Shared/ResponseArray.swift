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

struct ResponseArray<T: Codable>: Codable {
    let data: [T]
    let results: Int?
    let totalCount: Int?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case results = "Results"
        case totalCount = "TotalCount"
        case links = "Links"
    }
}

struct RangeResponse<E: Codable> {
    let response: ResponseArray<E>
    let offset: Int?
    let limit: Int?
    
    init(response: ResponseArray<E>, offset: Int? = nil, limit: Int? = nil) {
        self.response = response
        self.offset = offset
        self.limit = limit
    }
}
