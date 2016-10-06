//
//  ServiceBulletin.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class ServiceBulletin: Mappable {
    
    public dynamic var ItemNumber : String? = nil
    public dynamic var BulletinNumber : String? = nil
    public dynamic var ReplacementBulletinNumber : String? = nil
    public dynamic var DateAdded : String? = nil
    public dynamic var Component : String? = nil
    public dynamic var BulletinDate : String? = nil
    public dynamic var Summary : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init();
    }
    
    public required init() {
        
    }

    public func mapping(map: Map) {
        ItemNumber <- map["ItemNumber"]
        BulletinNumber <- map["BulletinNumber"]
        ReplacementBulletinNumber <- map["ReplacementBulletinNumber"]
        DateAdded <- map["DateAdded"]
        Component <- map["Component"]
        BulletinDate <- map["BulletinDate"]
        Summary <- map["Summary"]
    }
}
