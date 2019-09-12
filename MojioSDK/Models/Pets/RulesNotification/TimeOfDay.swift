/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2019 Copyright Moj.io Inc.
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

public protocol TimeOfDayModel: Codable {
    var hour: Int? { get }
    var minute: Int? { get }
}

public struct TimeOfDay: TimeOfDayModel {
    public let hour : Int?
    public let minute : Int?
    
    public enum CodingKeys: String, CodingKey {
        case hour = "Hour"
        case minute = "Minute"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.hour = try container.decodeIfPresent(Int.self, forKey: .hour)
            self.minute = try container.decodeIfPresent(Int.self, forKey: .minute)
           
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}
public struct TimeOfDayUpdate: Codable {
    public var hour : Int?
    public var minute : Int?
    
    public enum CodingKeys: String, CodingKey {
        case hour = "Hour"
        case minute = "Minute"
    }
    
    public init(model: TimeOfDay? = nil) {
        self.init(
            hour: model?.hour,
            minute: model?.minute
        )
    }
    
    public init(
        hour: Int? = nil,
        minute: Int? = nil) {
        
        self.hour = hour
        self.minute = minute
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.hour, forKey: .hour)
        try container.encodeIfPresent(self.minute, forKey: .minute)
    }
}
