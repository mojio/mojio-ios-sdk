//
//  User.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class User : Mappable {
    
    open dynamic var FirstName : String? = nil
    open dynamic var LastName : String? = nil
    open dynamic var UserName : String? = nil
    open dynamic var Jurisdiction : String? = nil
    open var Emails : [Email] = []
    open var PhoneNumbers : [PhoneNumber] = []
    open var Img : Image? = nil
    open var Tags : [String] = []
    open dynamic var Id : String? = nil
    open dynamic var CreatedOn : String? = nil
    open dynamic var LastModified : String? = nil
    
    /* PUT & POST properties */
    open dynamic var email : String? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {
        
    }
    
    open static func primaryKey() -> String? {
        return "Id"
    }
    
    open func EmailsArray() -> NSArray {
        return self.Emails as NSArray
    }
    
    open func PhoneNumbersArray() -> NSArray {
        return self.PhoneNumbers as NSArray
    }
    
    open func TagsArray() -> NSArray {
        return self.Tags as NSArray
    }

    open func jsonDict () -> NSDictionary {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.UserName != nil {
            dictionary.setObject(self.UserName!, forKey: "UserName" as NSCopying)
        }
        if self.email != nil {
            dictionary.setObject(self.email!, forKey: "Email" as NSCopying)
        }
        if self.FirstName != nil {
            dictionary.setObject(self.FirstName!, forKey: "FirstName" as NSCopying)
        }
        if self.LastName != nil {
            dictionary.setObject(self.LastName!, forKey: "LastName" as NSCopying)
        }
        
        return dictionary
    }
    
    open func mapping(map: Map) {
        
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
