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

public protocol BaseActivity: BaseActivityLocation {
    var StartTime: String? {get set}
    var EndTime: String? {get set}
    var Duration: String? {get set}
    var Published: String? {get set}
    var Updated: String? {get set}
    
    var Context: String? {get set}
    
    var Content: String? {get set}
    var Location: ActivityLocation? {get set}
    var AttributedTo: BaseActivity? {get set}
    var Summary: Dictionary<String,String>? {get set}
    var Icon: Dictionary<String, AnyObject>? {get set}
}

extension BaseActivity {
    
    public mutating func mapping(map: Map) {
        self.baseActivityMapping(map: map)
    }
    
    public mutating func baseActivityMapping(map: Map) {
        self.baseActivityLocationMapping(map: map)
        
        Context <- map["Context"]
        Location <- map["Location"]
        StartTime <- map["StartTime"]
        EndTime <- map["EndTime"]
        Duration <- map["Duration"]
        Published <- map["Published"]
        Updated <- map["Updated"]
        Summary <- map["SummaryMap"]
        Icon <- map["Icon"]
        Content <- map["Content"]
        AttributedTo <- map["AttributedTo"]
    }
}

public struct Activity: BaseActivity {
    
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
    public var Summary: Dictionary<String,String>? = nil
    public var Icon: Dictionary<String, AnyObject>? = nil
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }
}
