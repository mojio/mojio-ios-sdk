//
//  App.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-25.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class App: Mappable {
    
    open dynamic var Name : String? = nil
    open dynamic var Description : String? = nil
    open var Downloads : Int? = nil
    open var RedirectUris : [String] = []
    open var AppImage : Image? = nil
    open var Tags : [String] = []
    open dynamic var Id : String? = nil
    open dynamic var CreatedOn : String? = nil
    open dynamic var LastModified : String? = nil

    public required convenience init?(map: Map) {
        self.init();
    }
    
    open static func primaryKey() -> String? {
        return "Id"
    }
    
    public required init() {
        
    }
    
    open func json () -> String? {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Name != nil {
            dictionary.setObject(self.Name!, forKey: "Name" as NSCopying)
        }
        if self.Description != nil {
            dictionary.setObject(self.Description!, forKey: "Description" as NSCopying)
        }
        if self.RedirectUris.count > 0 {
            dictionary.setObject(self.RedirectUris, forKey: "RedirectUris" as NSCopying)
        }
        
        if dictionary.count == 0 {
            return nil
        }
        
        let data = try! JSONSerialization.data(withJSONObject: dictionary, options:  JSONSerialization.WritingOptions.prettyPrinted)
        
        return NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
    }
    
    open func mapping(map: Map) {
        
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
