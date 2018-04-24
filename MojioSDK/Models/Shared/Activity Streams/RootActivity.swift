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

public struct RootActivity: BaseActivity {
    
    // BaseActivityLocation
    public var Id: String? = nil
    public var ActivityType: String? = nil
    public var Href: String? = nil
    public var Name: String? = nil
    public var NameMap: Dictionary<String, String>? = nil
    
    // BaseActivity
    public var StartTime: String? = nil
    public var EndTime: String? = nil
    public var Duration: String? = nil
    public var Published: String? = nil
    public var Updated: String? = nil
    
    public var Context: String? = nil
    
    public var Content: String? = nil
    public var Location: ActivityLocation? = nil
    public var AttributedTo: BaseActivity? = nil
    public var Summary: Dictionary<String, String>? = nil
    public var Icon: Dictionary<String, Any>? = nil
    
    public var startTime: Date? = nil
    public var endTime: Date? = nil
    public var published: Date? = nil
    public var updated: Date? = nil

    // Root Values
    public var Actor: Activity? = nil
    public var Target: Activity? = nil
    public var Result: Activity? = nil
    public var Object: Activity? = nil
    public var Origin: Activity? = nil
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }

    public mutating func mapping(map: Map) {
        self.baseActivityMapping(map: map)
                
        Actor <- map["Actor"]
        Target <- map["Target"]
        Result <- map["Result"]
        Object <- map["Object"]
        Origin <- map["Origin"]
    }
}
