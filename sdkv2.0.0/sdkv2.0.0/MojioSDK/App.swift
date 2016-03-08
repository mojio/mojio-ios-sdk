//
//  App.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-25.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class App: Object, Mappable {
    
    dynamic var Name : String? = nil
    dynamic var Description : String? = nil
    var Downloads = RealmOptional<Int>()
    var RedirectUris = List<StringObject>()
    dynamic var AppImage : Image? = nil
    var Tags = List<StringObject>()
    dynamic var Id : String? = nil
    dynamic var CreatedOn : String? = nil
    dynamic var LastModified : String? = nil

    
    required convenience init?(_ map: Map) {
        self.init();
    }
    
    override static func primaryKey() -> String? {
        return "Id"
    }

    func json () -> NSString? {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Name != nil {
            dictionary.setObject(self.Name!, forKey: "Name")
        }
        if self.Description != nil {
            dictionary.setObject(self.Description!, forKey: "Description")
        }
        if self.RedirectUris.count > 0 {
            let array = self.RedirectUris.toArray()
            dictionary.setObject(array, forKey: "RedirectUris")
        }
        
        if dictionary.count == 0 {
            return nil
        }
        
        let data = try! NSJSONSerialization.dataWithJSONObject(dictionary, options:  NSJSONWritingOptions.PrettyPrinted)
        let string : NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
        return string
    }
    
    func mapping(map: Map) {
        
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