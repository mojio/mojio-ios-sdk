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
    var Summary: Dictionary<String, String>? {get set}
    var Icon: Dictionary<String, Any>? {get set}
    
    // Date/Time
    var startTime: Date? {get set}
    var endTime: Date? {get set}
    var published: Date? {get set}
    var updated: Date? {get set}
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
        
        var attributedToValue: Activity?
        attributedToValue <- map["AttributedTo"]
        AttributedTo = attributedToValue
        
        startTime = self.StartTime?.toDate
        endTime = self.EndTime?.toDate
        published = self.Published?.toDate
        updated = self.Updated?.toDate
    }
}
