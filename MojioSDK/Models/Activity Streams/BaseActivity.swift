//
//  ActivityLink.swift
//  MojioSDK
//
//  Created by Narayan Sainaney on 2016-06-27.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation
import ObjectMapper

public class BaseActivity : NSObject, Mappable {
    public dynamic var Id : String? = nil
    public dynamic var Type : String? = nil
    public dynamic var Href : String? = nil
    public dynamic var Name : String? = nil
    public dynamic var NameMap : Dictionary<String, String>? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        Id <- map["Id"]
        Type <- map["Type"]
        Href <- map["Href"]
        Name <- map["Name"]
        NameMap <- map["NameMap"]
    }

}