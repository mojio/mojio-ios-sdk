//
//  ServiceBulletin.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class ServiceBulletin: Object, Mappable {
    
    dynamic var ItemNumber : String? = nil
    dynamic var BulletinNumber : String? = nil
    dynamic var ReplacementBulletinNumber : String? = nil
    dynamic var DateAdded : String? = nil
    dynamic var Component : String? = nil
    dynamic var BulletinDate : String? = nil
    dynamic var Summary : String? = nil
    
    required convenience init?(_ map: Map) {
        self.init();
    }
    
    func mapping(map: Map) {
        
        ItemNumber <- map["ItemNumber"]
        BulletinNumber <- map["BulletinNumber"]
        ReplacementBulletinNumber <- map["ReplacementBulletinNumber"]
        DateAdded <- map["DateAdded"]
        Component <- map["Component"]
        BulletinDate <- map["BulletinDate"]
        Summary <- map["Summary"]

    }
}
