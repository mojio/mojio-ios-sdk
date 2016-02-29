//
//  User.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Realm

class User : Object, Mappable {
    
    dynamic var FirstName : String? = nil
    dynamic var LastName : String? = nil
    dynamic var UserName : String? = nil
    var Emails = List<Email>()
    var PhoneNumbers = List<PhoneNumber>()
    dynamic var Img : Image? = nil
    var Tags = List<StringObject>()
    dynamic var Id : String? = nil
    dynamic var CreatedOn : String? = nil
    dynamic var LastModified : String? = nil
    
    /* PUT & POST properties */
    dynamic var email : String? = nil
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func json () -> NSString? {
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
        if self.PhoneNumbers.count > 0 {
            let array = self.PhoneNumbers.toArray()
            dictionary.setObject(array, forKey: "PhoneNumbers")
        }
        
        let data = try! NSJSONSerialization.dataWithJSONObject(dictionary, options:  NSJSONWritingOptions.PrettyPrinted)
        let string : NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
        return string
    }
    
    func mapping(map: Map) {
        
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