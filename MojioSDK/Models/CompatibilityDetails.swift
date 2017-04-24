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

public enum VehicleCompatibilityLevel: String {
    case full = "Full"
    case partial = "Partial"
    case minimum = "Minimum"
    case notCompatible = "NotCompatible"
    case unknown = "Unknown"
}

public struct CompatibilityDetails: Mappable {
    
    public var Level: String? = nil
    public var Changed: Bool = false
    public var LastChecked: String? = nil
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }
    
    public mutating func mapping(map: Map) {
        Level <- map["Level"]
        Changed <- map["Changed"]
        LastChecked <- map["LastChecked"]
    }
}
