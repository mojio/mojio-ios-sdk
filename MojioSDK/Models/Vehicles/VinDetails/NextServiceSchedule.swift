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

//import UIKit
import Foundation

public struct NextServiceSchedule: Codable {

    public var TimeStamp: String? = nil
    public var Odometer: Double = 0
    public var AgeInMonths: Int? = nil
    public var TimeUnits: String? = nil
    public var TimeValue: Double = 0
    public var DistanceUnits: String? = nil
    public var DistanceValue: Double = 0
    public var Services: [PlatformServiceSchedule] = []
    
    //public var timeStamp: Date? = nil
    
    private enum CodingKeys: String, CodingKey {
        case TimeStamp
        case Odometer
        case AgeInMonths
        case TimeUnits
        case TimeValue
        case DistanceUnits
        case DistanceValue
        case Services = "Items"
    }
}

extension NextServiceSchedule {
    
    public var timeStamp: Date? {
        return self.TimeStamp?.toDate
    }
}


//public init() {}
//
//public init?(map: Map) {
//    self.init()
//}
//
//public mutating func mapping(map: Map) {
//    TimeStamp <- map["TimeStamp"]
//    Odometer <- map["Odometer"]
//    AgeInMonths <- map["AgeInMonths"]
//    TimeUnits <- map["TimeUnits"]
//    TimeValue <- map["TimeValue"]
//    DistanceUnits <- map["DistanceUnits"]
//    DistanceValue <- map["DistanceValue"]
//    Services <- map["Items"]
//
//    timeStamp = self.TimeStamp?.toDate
//}
