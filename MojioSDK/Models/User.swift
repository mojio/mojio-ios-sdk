//
//  User.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class User : Mappable {
    
    public dynamic var FirstName : String? = nil
    public dynamic var LastName : String? = nil
    public dynamic var UserName : String? = nil
    public dynamic var Jurisdiction : String? = nil
    public var Emails : [Email] = []
    public var PhoneNumbers : [PhoneNumber] = []
    public var Img : Image? = nil
    public var Tags : [String] = []
    public dynamic var Id : String? = nil
    public dynamic var CreatedOn : String? = nil
    public dynamic var LastModified : String? = nil
    
    /* PUT & POST properties */
    public dynamic var email : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }
    
    public static func primaryKey() -> String? {
        return "Id"
    }
    
    public func EmailsArray() -> NSArray {
        return self.Emails
    }
    
    public func PhoneNumbersArray() -> NSArray {
        return self.PhoneNumbers
    }
    
    public func TagsArray() -> NSArray {
        return self.Tags
    }

    public func jsonDict () -> NSDictionary {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.UserName != nil {
            dictionary.setObject(self.UserName!, forKey: "UserName")
        }
        if self.email != nil {
            dictionary.setObject(self.email!, forKey: "Email")
        }
        if self.FirstName != nil {
            dictionary.setObject(self.FirstName!, forKey: "FirstName")
        }
        if self.LastName != nil {
            dictionary.setObject(self.LastName!, forKey: "LastName")
        }
        
        return dictionary
    }
    
    public func mapping(map: Map) {
        
        self.FirstName <- map["FirstName"]
        self.LastName <- map["LastName"]
        self.UserName <- map["UserName"]
        self.Jurisdiction <- map["Jurisdiction"]
        self.Emails <- map["Emails"]
        self.PhoneNumbers <- map["PhoneNumbers"]
        self.Img <- map["Image"]
        self.Tags <- map["Tags"]
        self.Id <- map["Id"]
        self.CreatedOn <- map["CreatedOn"]
        self.LastModified <- map["LastModified"]
    }
}
