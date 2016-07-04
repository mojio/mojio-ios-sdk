//
//  BaseActivity.swift
//  MojioSDK
//
//  Created by Narayan Sainaney on 2016-06-27.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation
import ObjectMapper

public class Activity : BaseActivity {
    public dynamic var StartTime : String? = nil
    public dynamic var EndTime : String? = nil
    public dynamic var Duration : String? = nil
    public dynamic var Published : String? = nil
    public dynamic var Updated : String? = nil
    
    public dynamic var Context : String? = nil
    
    public dynamic var Location : ActivityLocation? = nil
    public dynamic var Origin : ActivityLocation? = nil
    public dynamic var Summary : Dictionary<String,String>? = nil
    public var Icon : Dictionary<String, AnyObject>? = nil
    
    public required override init() {
        super.init()
    }
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public override func mapping(map: Map) {
        super.mapping(map)
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