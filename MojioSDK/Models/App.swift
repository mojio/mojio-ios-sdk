//
//  App.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-25.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class App: Object, Mappable {
    
    public dynamic var Name : String? = nil
    public dynamic var Description : String? = nil
    public var Downloads = RealmOptional<Int>()
    public var RedirectUris = List<StringObject>()
    public dynamic var AppImage : Image? = nil
    public var Tags = List<StringObject>()
    public dynamic var Id : String? = nil
    public dynamic var CreatedOn : String? = nil
    public dynamic var LastModified : String? = nil

    
    public required convenience init?(_ map: Map) {
        self.init();
    }
    
    public override static func primaryKey() -> String? {
        return "Id"
    }
    
    public func RedirectUrisArray() -> NSArray {
        return self.RedirectUris.toArray()
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
        if self.RedirectUris.count > 0 {
            dictionary.setObject(self.RedirectUris.toArray(), forKey: "RedirectUris")
        }
        
        if dictionary.count == 0 {
            return nil
        }
        
        let data = try! NSJSONSerialization.dataWithJSONObject(dictionary, options:  NSJSONWritingOptions.PrettyPrinted)
        let string : NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
        return string
    }
    
    public func DownloadsAsIntNumber() -> NSNumber {
        return self.Downloads.value! as NSNumber
    }
    
    public func mapping(map: Map) {
        
        var tags = Array<String>()
        tags <- map["Tags"]
        
        for tag in tags {
            let string = StringObject()
            string.value = tag
            
            self.Tags.append(string)
        }
        
        var redirectURIs = Array<String>()
        redirectURIs <- map["RedirectUris"]
        
        for uri in redirectURIs {
            let string = StringObject()
            string.value = uri
            
            self.Tags.append(string)
        }

        Name <- map["Name"]
        Description <- map["Description"]
        Downloads <- map["Downloads"]
        AppImage <- map["Image"]
        Id <- map["Id"]
        CreatedOn <- map["CreatedOn"]
        LastModified <- map["LastModified"]

    }

}