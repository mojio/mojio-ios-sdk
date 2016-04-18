//
//  Group.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class Group: Object, Mappable {
    public dynamic var Name : String? = nil
    public dynamic var Description : String? = nil
    public var Users = List<User>()
    public var Tags = List<StringObject>()
    public dynamic var Id : String? = nil
    public dynamic var CreatedOn : String? = nil
    public dynamic var LastModified : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public override static func primaryKey() -> String? {
        return "Id"
    }
    
    public func UsersArray() -> NSArray {
        return self.Users.toArray()
    }
    
    public func TagsArray() -> NSArray {
        return self.Tags.toArray()
    }
    
    public func json () -> NSString? {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Name != nil {
            dictionary.setObject(self.Name!, forKey: "Name")
        }
        if self.Description != nil {
            dictionary.setObject(self.Description!, forKey: "Description")
        }
        if self.Users.count > 0 {
            dictionary.setObject(self.Users.toArray(), forKey: "Users")
        }
        
        let data = try! NSJSONSerialization.dataWithJSONObject(dictionary, options:  NSJSONWritingOptions.PrettyPrinted)
        let string : NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
        return string

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
            let string = StringObject()
            string.value = tag
            
            self.Tags.append(string)
        }

        
        Name <- map["Name"];
        Description <- map["Description"];
        Id <- map["Id"];
        CreatedOn <- map["CreatedOn"];
        LastModified <- map["LastModified"];
    }

}
