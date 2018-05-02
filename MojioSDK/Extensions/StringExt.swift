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
import SwiftDate

internal extension String {
    
    internal static let empty = String()
    
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

        if let date = DateInRegion.init(string: self, format: .rss(alt: false), fromRegion: Region.GMT()) {
            return date.absoluteDate
        }

        return nil
    }

    var dateFromIso8601: Date? {
        if let date : Date = self.date(format: DateFormat.iso8601(options: .withInternetDateTime))?.absoluteDate {
            return date
        }
        
        if let date : Date = self.date(format: DateFormat.iso8601(options: .withInternetDateTimeExtended))?.absoluteDate {
            return date
        }
        
        if let date : Date = self.date(format: DateFormat.iso8601(options: [.withFullDate, .withTime]))?.absoluteDate {
            return date
        }
        
        return nil
    }
}
