//
//  Email.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class Email: Mappable {
    var Verified : Bool?;
    var Address : String?;
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        Verified <- map["Verified"];
        Address <- map["Address"];
    }

}