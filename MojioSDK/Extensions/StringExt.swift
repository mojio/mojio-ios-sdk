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
        
        if let date =  DateInRegion(self, format:  ISOFormatter.Options.withFullDate.dateFormat, region: Region.ISO) {
            return date.date
        }
        
        if let date = DateInRegion(self, format: ISOFormatter.Options.withInternetDateTimeExtended.dateFormat, region: Region.ISO) {
            return date.date
        }
        
        if let date = DateInRegion(self, format: ISOFormatter.Options.withInternetDateTime.dateFormat, region: Region.ISO) {
            return date.date
        }

        if let date = DateInRegion(self, format: DateFormats.rss, region: Region.ISO) {
            return date.date
        }

        return nil
    }

    internal var dateFromISO: Date? {
        if let date : Date = self.toDate(ISOFormatter.Options.withInternetDateTime.dateFormat, region: Region.ISO)?.date {
            return date
        }
        
        if let date : Date = self.toDate(ISOFormatter.Options.withInternetDateTimeExtended.dateFormat, region: Region.ISO)?.date {
            return date
        }
        
        if let date : Date = self.toDate([ISOFormatter.Options.withFullDate.dateFormat, ISOFormatter.Options.withTime.dateFormat], region: Region.ISO)?.date {
            return date
        }
        
        return nil
    }
}

extension String {
    var capitalizedFirstCharacter: String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    var decapitalizedFirstCharacter: String {
        return prefix(1).lowercased() + dropFirst()
    }
}
