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
    
    public enum CodingKeysPascal: String, CodingKey {
        case data = "Data"
        case results = "Results"
        case totalCount = "TotalCount"
        case links = "Links"
    }
    
    public enum CodingKeysCamel: String, CodingKey {
        case data = "data"
        case results = "results"
        case totalCount = "totalCount"
        case links = "links"
    }
    
    private init(container: KeyedDecodingContainer<CodingKeysPascal>) throws {
        self.data = try container.decodeIfPresent([T].self, forKey: .data) ?? []
        self.results = try container.decodeIfPresent(Int.self, forKey: .results)
        self.totalCount = try container.decodeIfPresent(Int.self, forKey: .totalCount)
        self.links = try container.decodeIfPresent(Links.self, forKey: .links)
    }
    
    private init(container: KeyedDecodingContainer<CodingKeysCamel>) throws {
        self.data = try container.decodeIfPresent([T].self, forKey: .data) ?? []
        self.results = try container.decodeIfPresent(Int.self, forKey: .results)
        self.totalCount = try container.decodeIfPresent(Int.self, forKey: .totalCount)
        self.links = try container.decodeIfPresent(Links.self, forKey: .links)
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeysPascal.self)
            _ = try container.decode(Int.self, forKey: .results)
            try self.init(container: container)
        }
        catch {
            do {
                try self.init(container: try decoder.container(keyedBy: CodingKeysCamel.self))
            }
            catch let error {
                debugPrint(error)
                throw error
            }
        }
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
