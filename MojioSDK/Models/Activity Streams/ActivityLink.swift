//
//  ActivityLink.swift
//  MojioSDK
//
//  Created by Narayan Sainaney on 2016-06-27.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation
import ObjectMapper

@objc public class ActivityLink : NSObject, Mappable {
    public dynamic var Id : String? = nil
    public dynamic var Type : String? = nil
    public dynamic var Href : String? = nil

    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        Id <- map["Id"]
        Type <- map["Type"]
        Href <- map["Href"]
    }

}