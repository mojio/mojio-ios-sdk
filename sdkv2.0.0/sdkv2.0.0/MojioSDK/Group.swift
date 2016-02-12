//
//  Group.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class Group: Mappable {
    var Name : String?;
    var Description : String?;
    var Users : [User]?;
    var Tags : NSArray?;
    var Id : String?;
    var CreatedOn : String?;
    var LastModified : String?;
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        Name <- map["Name"];
        Description <- map["Description"];
        Users <- map["Users"];
        Tags <- map["Tags"];
        Id <- map["Id"];
        CreatedOn <- map["CreatedOn"];
        LastModified <- map["LastModified"];
    }

}
