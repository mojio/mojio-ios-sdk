//
//  PhoneNumber.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Realm

class PhoneNumber : Object, Mappable {

    dynamic var Type : String? = nil //['Home', 'Work', 'Mobile'],
    dynamic var CountryCode : Int = 0
    dynamic var AreaCode : Int = 0
    dynamic var Number : Int = 0
    dynamic var Ext : Int = 0
    
    required convenience init?(_ map: Map) {
        self.init();
    }

    
    func mapping(map: Map) {
        Type <- map["Type"];
        CountryCode <- map["CountryCode"];
        AreaCode <- map["AreaCode"];
        Number <- map["Number"];
        Ext <- map["Ext"];
    }
}