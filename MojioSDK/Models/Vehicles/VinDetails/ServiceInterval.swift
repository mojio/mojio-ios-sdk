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

public struct ServiceInterval: Codable {
    
    public var OperatingParameter: String? = nil
    public var OperatingParameterNotes: String? = nil
    public var IntervalType: String? = nil
    public var value: Double = 0
    public var units: String? = nil
    public var InitialValue: Double = 0
}

//public init() {}
//
//public init?(map: Map) {
//    self.init()
//}
//
//public mutating func mapping(map: Map) {
//    OperatingParameter <- map["OperatingParameter"]
//    OperatingParameterNotes <- map["OperatingParameterNotes"]
//    IntervalType <- map["IntervalType"]
//    Value <- map["Value"]
//    Units <- map["Units"]
//    InitialValue <- map["InitialValue"]
//}
