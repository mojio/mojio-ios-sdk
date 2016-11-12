//
//  Group.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class Group: Mappable {
    public dynamic var Name : String? = nil
    public dynamic var Description : String? = nil
    public var Users : [User] = []
    public var Tags : [String] = []
    public dynamic var Id : String? = nil
    public dynamic var CreatedOn : String? = nil
    public dynamic var LastModified : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    public static func primaryKey() -> String? {
        return "Id"
    }
    
    public func json () -> String? {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Name != nil {
            dictionary.setObject(self.Name!, forKey: "Name")
        }
        if self.Description != nil {
            dictionary.setObject(self.Description!, forKey: "Description")
        }
        if self.Users.count > 0 {
            dictionary.setObject(self.Users, forKey: "Users")
        }
        
        let data = try! NSJSONSerialization.dataWithJSONObject(dictionary, options:  NSJSONWritingOptions.PrettyPrinted)
        return NSString(data: data, encoding: NSUTF8StringEncoding)! as String

    }
    
    public func mapping(map: Map) {
        
        var users = Array<User>()
        users <- map["Users"]
        
        for user in users {
            self.Users.append(user)
        }
        
        var tags = Array<String>()
        tags <- map["Tags"]
        
        for tag in tags {
            self.Tags.append(tag)
        }
        
        Name <- map["Name"];
        Description <- map["Description"];
        Id <- map["Id"];
        CreatedOn <- map["CreatedOn"];
        LastModified <- map["LastModified"];
    }

}
