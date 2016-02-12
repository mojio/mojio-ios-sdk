//
//  User.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper


class User : Mappable {
    
    var FirstName : String?;
    var LastName : String?;
    var UserName : String?;
    var Emails : [Email]?;
    var PhoneNumbers : [PhoneNumber]?;
    var Img : Image?;
    var Tags : [String]?;
    var Id : String?;
    var CreatedOn : String?;
    var LastModified : String?;
    //    var Links : String?;
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        FirstName <- map["FirstName"];
        LastName <- map["LastName"];
        UserName <- map["UserName"];
        Emails <- map["Emails"];// ?? [];
        PhoneNumbers <- map["PhoneNumber"];// ?? [];
        Img <- map["Image"];
        Tags <- map["Tags"];
        Id <- map["Id"];
        CreatedOn <- map["CreatedOn"];
        LastModified <- map["LastModified"];
    }
}