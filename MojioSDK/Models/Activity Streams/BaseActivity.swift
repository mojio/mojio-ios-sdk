//
//  BaseActivity.swift
//  MojioSDK
//
//  Created by Narayan Sainaney on 2016-06-27.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation
import ObjectMapper

@objc public class BaseActivity : NSObject, Mappable {
    public dynamic var Id : String? = nil

    public dynamic var Name : String? = nil
    public dynamic var NameMap : Dictionary<String, String>? = nil
    
    public dynamic var Type : String? = nil
    public dynamic var Context : String? = nil
    
    public dynamic var Location : ActivityLocation? = nil
    public dynamic var Origin : ActivityLink? = nil
    
    public required override init() {
        super.init()
    }
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        Id <- map["Id"]
        Name <- map["Name"]
        NameMap <- map["NameMap"]
        Type <- map["Type"]
        Context <- map["Context"]
        Location <- map["Location"]
        Origin <- map["Origin"]

    }
}