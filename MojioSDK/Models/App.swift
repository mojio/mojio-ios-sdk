//
//  App.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-25.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class App: Mappable {
    
    public dynamic var Name : String? = nil
    public dynamic var Description : String? = nil
    public var Downloads : Int? = nil
    public var RedirectUris : [String] = []
    public var AppImage : Image? = nil
    public var Tags : [String] = []
    public dynamic var Id : String? = nil
    public dynamic var CreatedOn : String? = nil
    public dynamic var LastModified : String? = nil

    public required convenience init?(_ map: Map) {
        self.init();
    }
    
    public static func primaryKey() -> String? {
        return "Id"
    }
    
    public required init() {
        
    }
    
    public func json () -> String? {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Name != nil {
            dictionary.setObject(self.Name!, forKey: "Name")
        }
        if self.Description != nil {
            dictionary.setObject(self.Description!, forKey: "Description")
        }
        if self.RedirectUris.count > 0 {
            dictionary.setObject(self.RedirectUris, forKey: "RedirectUris")
        }
        
        if dictionary.count == 0 {
            return nil
        }
        
        let data = try! NSJSONSerialization.dataWithJSONObject(dictionary, options:  NSJSONWritingOptions.PrettyPrinted)
        
        return NSString(data: data, encoding: NSUTF8StringEncoding)! as String
    }
    
    public func mapping(map: Map) {
        
        Name <- map["Name"]
        Description <- map["Description"]
        Downloads <- map["Downloads"]
        RedirectUris <- map["RedirectUris"]
        AppImage <- map["Image"]
        Tags <- map["Tags"]
        Id <- map["Id"]
        CreatedOn <- map["CreatedOn"]
        LastModified <- map["LastModified"]

    }

}