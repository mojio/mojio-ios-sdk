//
//  Activity.swift
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

    public dynamic var Actor : BaseActivity? = nil
    public dynamic var Target : BaseActivity? = nil
    public dynamic var Result : BaseActivity? = nil
    public dynamic var Object : BaseActivity? = nil
    public dynamic var Summary : Dictionary<String,String>? = nil

    public required convenience init?(_ map: Map) {
        self.init()
    }

    public override func mapping(map: Map) {
        super.mapping(map)
        
        StartTime <- map["StartTime"]
        EndTime <- map["EndTime"]
        Duration <- map["Duration"]
        Published <- map["Published"]
        Updated <- map["Updated"]
        
        Actor <- map["Actor"]
        Target <- map["Target"]
        Result <- map["Result"]
        Object <- map["Object"]
        Summary <- map["SummaryMap"]        
    }
}