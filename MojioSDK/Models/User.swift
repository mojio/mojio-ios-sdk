//
//  User.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Realm

public class User : Object, Mappable {
    
    public dynamic var FirstName : String? = nil
    public dynamic var LastName : String? = nil
    public dynamic var UserName : String? = nil
    public var Emails = List<Email>()
    public var PhoneNumbers = List<PhoneNumber>()
    public dynamic var Img : Image? = nil
    public var Tags = List<StringObject>()
    public dynamic var Id : String? = nil
    public dynamic var CreatedOn : String? = nil
    public dynamic var LastModified : String? = nil
    
    /* PUT & POST properties */
    public dynamic var email : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public override static func primaryKey() -> String? {
        return "Id"
    }
    
    public func EmailsArray() -> NSArray {
        return self.Emails.toArray()
    }
    
    public func PhoneNumbersArray() -> NSArray {
        return self.PhoneNumbers.toArray()
    }
    
    public func TagsArray() -> NSArray {
        return self.Tags.toArray()
    }

    public func json () -> NSString? {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.UserName != nil {
            dictionary.setObject(self.UserName!, forKey: "UserName")
        }
        if self.Emails.count > 0 {
            self.email = (self.Emails.first! as Email).Address
            dictionary.setObject(self.email!, forKey: "Email")
        }
        if self.FirstName != nil {
            dictionary.setObject(self.FirstName!, forKey: "FirstName")
        }
        if self.LastName != nil {
            dictionary.setObject(self.LastName!, forKey: "LastName")
        }
        if self.PhoneNumbers.count > 0 {
            dictionary.setObject(self.PhoneNumbers.toArray(), forKey: "PhoneNumbers")
        }
        
        let data = try! NSJSONSerialization.dataWithJSONObject(dictionary, options:  NSJSONWritingOptions.PrettyPrinted)
        let string : NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
        return string
    }
    
    public func mapping(map: Map) {
        
        var emails = Array<Email>()
        emails <- map["Emails"]
        
        for email in emails {
            self.Emails.append(email)
        }
        
        var tags = Array<String>()
        tags <- map["Tags"]
        
        for tag in tags {
            let string = StringObject()
            string.value = tag
            
            self.Tags.append(string)
        }
        
        var phoneNumbers = Array<PhoneNumber>()
        phoneNumbers <- map["PhoneNumbers"]
        
        for phoneNumber in phoneNumbers {
            self.PhoneNumbers.append(phoneNumber)
        }
        
        self.FirstName <- map["FirstName"];
        self.LastName <- map["LastName"];
        self.UserName <- map["UserName"];
        Img <- map["Image"];
        self.Id <- map["Id"];
        self.CreatedOn <- map["CreatedOn"];
        self.LastModified <- map["LastModified"];
    }
}