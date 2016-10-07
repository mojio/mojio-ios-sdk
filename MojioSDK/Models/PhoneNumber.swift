//
//  PhoneNumber.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class PhoneNumber : Mappable {

    public dynamic var PhoneNumber : String? = nil
    public dynamic var Verified : Bool = false
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }
    
    public func mapping(map: Map) {
        PhoneNumber <- map["PhoneNumber"];
        Verified <- map["Verified"];
    }
}