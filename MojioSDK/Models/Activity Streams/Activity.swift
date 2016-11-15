//
//  BaseActivity.swift
//  MojioSDK
//
//  Created by Narayan Sainaney on 2016-06-27.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation
import ObjectMapper

open class Activity : BaseActivity {
    open dynamic var StartTime : String? = nil
    open dynamic var EndTime : String? = nil
    open dynamic var Duration : String? = nil
    open dynamic var Published : String? = nil
    open dynamic var Updated : String? = nil
    
    open dynamic var Context : String? = nil
    
    open dynamic var Location : ActivityLocation? = nil
    open dynamic var Origin : ActivityLocation? = nil
    open dynamic var Summary : Dictionary<String,String>? = nil
    open var Icon : Dictionary<String, AnyObject>? = nil
    
    public required override init() {
        super.init()
    }
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    open override func mapping(map: Map) {
        super.mapping(map: map)
        Context <- map["Context"]
        Location <- map["Location"]
        Origin <- map["Origin"]
        StartTime <- map["StartTime"]
        EndTime <- map["EndTime"]
        Duration <- map["Duration"]
        Published <- map["Published"]
        Updated <- map["Updated"]
        Summary <- map["SummaryMap"]
        Icon <- map["Icon"]
    }
}
