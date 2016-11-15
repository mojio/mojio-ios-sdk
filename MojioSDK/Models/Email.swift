//
//  Email.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class Email: Mappable {
    open dynamic var Verified : Bool = false
    open dynamic var Address : String? = nil
    
    public required convenience init?(map: Map) {
        self.init();
    }
    
    public required init () {
        
    }
    
    open func mapping(map: Map) {
        self.Verified <- map["Verified"];
        self.Address <- map["Address"];
    }

}
