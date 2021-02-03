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

internal extension TimeInterval {
    static func from(_ string: String?, pattern: String? = nil, multipliers: [Double]? = nil) -> TimeInterval? {
        guard let string = string else { return nil }
        let pattern = pattern ?? "^(\\d+)?\\.?(\\d{2}):(\\d{2}):(\\d{2})(\\.\\d+)?$"
        let secondsPerMinute = 60.0
        let secondsPerHour = 60.0 * secondsPerMinute
        let secondsPerDay = 24.0 * secondsPerHour
        let multipliers = multipliers ?? [
            secondsPerDay,
            secondsPerHour,
            secondsPerMinute,
            1,
            1
        ]
        let regxp = try? NSRegularExpression(pattern: pattern, options: [])
        
        guard
            let matches = (regxp?.matches(in: string, options:[], range:NSMakeRange(0, string.count)).map{ $0 }),
            matches.count > 0 && matches[0].numberOfRanges > multipliers.count else { return nil }
        let durationComponents = matches[0]
        
        var result: TimeInterval = 0
        multipliers.enumerated().forEach { index, multiplier in
            let range = durationComponents.range(at: index + 1)
            guard range.location != NSNotFound else { return }
            result += (Double((string as NSString).substring(with: range)) ?? 0) * multiplier
        }
        return result
    }
}
