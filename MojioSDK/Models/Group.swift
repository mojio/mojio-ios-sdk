//
//  Group.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class Group: Mappable {
    open dynamic var Name : String? = nil
    open dynamic var Description : String? = nil
    open var Users : [User] = []
    open var Tags : [String] = []
    open dynamic var Id : String? = nil
    open dynamic var CreatedOn : String? = nil
    open dynamic var LastModified : String? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    open static func primaryKey() -> String? {
        return "Id"
    }
    
    open func json () -> String? {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Name != nil {
            dictionary.setObject(self.Name!, forKey: "Name" as NSCopying)
        }
        if self.Description != nil {
            dictionary.setObject(self.Description!, forKey: "Description" as NSCopying)
        }
        if self.Users.count > 0 {
            dictionary.setObject(self.Users, forKey: "Users" as NSCopying)
        }
        
        let data = try! JSONSerialization.data(withJSONObject: dictionary, options:  JSONSerialization.WritingOptions.prettyPrinted)
        return NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String

    }
    
    open func mapping(map: Map) {
        
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
