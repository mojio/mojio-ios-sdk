//
//  Transmission.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class Transmission: Mappable {
    
    public dynamic var Name : String? = nil
    public dynamic var Type : String? = nil
    public dynamic var DetailType : String? = nil
    public dynamic var Gears : String? = nil

    public required convenience init?(_ map: Map) {
        self.init();
    }
    
    public required init() {
        
    }

    public func mapping(map: Map) {
        Name <- map["Name"]
        Type <- map["Type"]
        DetailType <- map["DetailType"]
        Gears <- map["Gears"]
    }

}
