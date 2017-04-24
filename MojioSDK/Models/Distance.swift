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

// Units in DistanceUnits
public struct Distance: DeviceMeasurement {
    
    // DeviceMeasurement
    public var BaseUnit: String? = nil
    public var BaseValue: Double = 0
    public var Unit: String? = nil
    public var Value: Double = 0
    public var Timestamp: String?  = nil
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }
    
    public func jsonDict() -> [String:Any] {
        var map: [String:Any] = [:]
        
        if let baseUnit = self.BaseUnit {
            map["BaseUnit"] = baseUnit as AnyObject?
            map["BaseValue"] = self.BaseValue as AnyObject?
        }
        
        if let unit = self.Unit {
            map["Unit"] = unit as AnyObject?
            map["Value"] = self.Value as AnyObject?
        }

        return map
    }
}
