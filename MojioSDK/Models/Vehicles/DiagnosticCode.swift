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

public struct DiagnosticCode: Codable {
    
    public var ignored: Bool = false
    public var code: String? = nil
    public var description: String? = nil
    public var timestamp: Date? = nil
    
    // RiskSeverity
    public var severity: String? = nil
    public var instructions: String? = nil
    
    // Type
    public var stateType: String? = nil
    public var diagnosticCodeType: String? = nil

    private enum CodingKeys: String, CodingKey {
        case ignored = "Ignored"
        case code = "Code"
        case description = "Description"
        case timestamp = "Timestamp"
        case severity = "Severity"
        case instructions = "Instructions"
        case stateType = "StateType"
        case diagnosticCodeType = "Type"
    }
    
//    public func jsonIgnoredDict () -> [String: Any] {
//        return ["Ignored": self.Ignored]
//    }

}
