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

public protocol BirthdayModel: Codable {
    var year: Int? { get }
    var month: Int? { get }
    var day: Int? { get }
}

public struct Birthday: BirthdayModel {
    
    public let  year: Int?
    public let  month: Int?
    public let  day: Int?
    
    public enum CodingKeys: String, CodingKey {
        case year = "Year"
        case month = "Month"
        case day = "Day"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.year = try container.decodeIfPresent(Int.self, forKey: .year)
            self.month = try container.decodeIfPresent(Int.self, forKey: .month)
            self.day = try container.decodeIfPresent(Int.self, forKey: .day)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}
public struct BirthdayUpdate: Codable {
    
    public var year: Int? = nil
    public var month: Int? = nil
    public var day: Int? = nil
    
    
    public enum CodingKeys: String, CodingKey {
        case year = "Year"
        case month = "Month"
        case day = "Day"
    }
    
    public init(model: Birthday? = nil) {
        self.init(
            year: model?.year,
            month: model?.month,
            day: model?.day
        )
    }
    
    public init(
        year: Int? = nil,
        month: Int? = nil,
        day: Int? = nil) {
        
        self.year = year
        self.month = month
        self.day = day
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.year, forKey: .year)
        try container.encodeIfPresent(self.month, forKey: .month)
        try container.encodeIfPresent(self.day, forKey: .day)
    }
}
