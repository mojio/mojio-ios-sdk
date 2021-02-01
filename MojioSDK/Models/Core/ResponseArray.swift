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

public protocol ResponseArrayModel: Codable {
    
    associatedtype T: Codable
    associatedtype L: LinksModel
    
    var data: [T] { get }
    var results: Int? { get }
    var totalCount: Int? { get }
    var links: L? { get }
}

public struct ResponseArray<T: Codable>: ResponseArrayModel {
    
    public typealias L = Links
    
    public let data: [T]
    public let results: Int?
    public let totalCount: Int?
    public let links: L?
    
    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case data = "Data"
        case results = "Results"
        case totalCount = "TotalCount"
        case links = "Links"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKey.self)
        
        self.data = try container.decodeIgnoringCase([T].self, forKey: CodingKeys.data)
        self.results = try container.decodeIfPresentIgnoringCase(Int.self, forKey: CodingKeys.results)
        self.totalCount = try container.decodeIfPresentIgnoringCase(Int.self, forKey: CodingKeys.totalCount)
        self.links = try container.decodeIfPresentIgnoringCase(Links.self, forKey: CodingKeys.links)
    }
}

public protocol RangeResponseModel {
    
    associatedtype E: Codable
    
    var response: ResponseArray<E> { get }
    var offset: Int? { get }
    var limit: Int? { get }
}

public struct RangeResponse<E: Codable>: RangeResponseModel {
    public let response: ResponseArray<E>
    public let offset: Int?
    public let limit: Int?
    
    public init(response: ResponseArray<E>, offset: Int? = nil, limit: Int? = nil) {
        self.response = response
        self.offset = offset
        self.limit = limit
    }
}
