//
//  ActivityLink.swift
//  MojioSDK
//
//  Created by Narayan Sainaney on 2016-06-27.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation
import ObjectMapper

open class BaseActivity : NSObject, Mappable {
    open dynamic var Id : String? = nil
    open dynamic var ActivityType : String? = nil
    open dynamic var Href : String? = nil
    open dynamic var Name : String? = nil
    open dynamic var NameMap : Dictionary<String, String>? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    open func mapping(map: Map) {
        Id <- map["Id"]
        ActivityType <- map["Type"]
        Href <- map["Href"]
        Name <- map["Name"]
        NameMap <- map["NameMap"]
    }

}
