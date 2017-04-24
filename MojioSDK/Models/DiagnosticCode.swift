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

import UIKit
import ObjectMapper

public struct DiagnosticCode: Mappable {
    
    public var Ignored: Bool = false
    public var Code: String? = nil
    public var Description: String? = nil
    public var Timestamp: String? = nil
    
    // RiskSeverity
    public var Severity: String? = nil
    public var Instructions: String? = nil
    
    // Type
    public var StateType: String? = nil
    public var DiagnosticCodeType: String? = nil
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }
    
    public func jsonIgnoredDict () -> [String: Any] {
        return ["Ignored": self.Ignored]
    }
    
    public mutating func mapping(map: Map) {
        Ignored <- map["Ignored"]
        Code <- map["Code"]
        Description <- map["Description"]
        Timestamp <- map["Timestamp"]
        Severity <- map["Severity"]
        Instructions <- map["Instructions"]
        StateType <- map["StateType"]
        DiagnosticCodeType <- map["Type"]
    }
}
