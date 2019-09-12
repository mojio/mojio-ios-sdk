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

public protocol WeekDaysModel: Codable {
    
    associatedtype S: TimeOfDayModel
    associatedtype E: TimeOfDayModel
    
    var allDay: Bool? { get }
    var startTimeOfDay: S? { get }
    var endTimeOfDay: E? { get }
}

public struct WeekDays: WeekDaysModel {
    
    public typealias S = TimeOfDay
    public typealias E = TimeOfDay
    
    public let allDay : Bool?
    public let startTimeOfDay : S?
    public let endTimeOfDay : E?
    
    public enum CodingKeys: String, CodingKey {
        case allDay = "AllDay"
        case startTimeOfDay = "StartTimeOfDay"
        case endTimeOfDay = "EndTimeOfDay"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.allDay = try container.decodeIfPresent(Bool.self, forKey: .allDay)
            self.startTimeOfDay = try container.decodeIfPresent(TimeOfDay.self, forKey: .startTimeOfDay)
            self.endTimeOfDay = try container.decodeIfPresent(TimeOfDay.self, forKey: .endTimeOfDay)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}
public struct WeekDaysUpdate: Codable {
    
    public var allDay : Bool?
    public var startTimeOfDay : TimeOfDayUpdate?
    public var endTimeOfDay : TimeOfDayUpdate?
    
    public enum CodingKeys: String, CodingKey {
        case allDay = "AllDay"
        case startTimeOfDay = "StartTimeOfDay"
        case endTimeOfDay = "EndTimeOfDay"
    }
    
    public init(model: WeekDays? = nil) {
        self.init(
            allDay: model?.allDay,
            startTimeOfDay: TimeOfDayUpdate(model: model?.startTimeOfDay),
            endTimeOfDay: TimeOfDayUpdate(model: model?.endTimeOfDay)
        )
    }
    public init(
        allDay: Bool? = nil,
        startTimeOfDay: TimeOfDayUpdate? = nil,
        endTimeOfDay: TimeOfDayUpdate? = nil) {
        
        self.allDay = allDay
        self.startTimeOfDay = startTimeOfDay
        self.endTimeOfDay = endTimeOfDay
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.allDay, forKey: .allDay)
        try container.encodeIfPresent(self.startTimeOfDay, forKey: .startTimeOfDay)
        try container.encodeIfPresent(self.endTimeOfDay, forKey: .endTimeOfDay)
    }
}


