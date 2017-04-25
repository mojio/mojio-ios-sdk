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
import ObjectMapper
import SwiftDate

internal extension String {
    // Date conversion
    internal var toDate: Date? {
        
        if let date =  DateInRegion.init(string: self, format: .iso8601(options: .withFullDate), fromRegion: Region.GMT()) {
            return date.absoluteDate
        }
        
        if let date = DateInRegion.init(string: self, format: .iso8601(options: .withInternetDateTimeExtended), fromRegion: Region.GMT()) {
            return date.absoluteDate
        }
        
        if let date = DateInRegion.init(string: self, format: .iso8601(options: .withInternetDateTime), fromRegion: Region.GMT()) {
            return date.absoluteDate
        }
        
        return nil
    }
}

public protocol PrimaryKey {
    static var primaryKey: String {get}
}

// Base Device Measurement
public protocol DeviceMeasurement: Mappable {
    var BaseUnit: String? {get set}
    var BaseValue: Double {get set}
    var Unit: String? {get set}
    var Value: Double {get set}
    var Timestamp: String? {get set}
    
    var timeStamp: Date? {get set}
}

extension DeviceMeasurement {
    public mutating func mapping(map: Map) {
        self.measureMapping(map: map)
    }
    
    public mutating func measureMapping(map: Map) {
        BaseUnit <- map["BaseUnit"]
        BaseValue <- map["BaseValue"]
        Unit <- map["Unit"]
        Value <- map["Value"]
        Timestamp <- map["Timestamp"]
        
        timeStamp = self.Timestamp?.toDate
    }
}
