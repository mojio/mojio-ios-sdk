//
//  PhoneNumber.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class PhoneNumber: Mappable {
    var Type : String?; //['Home', 'Work', 'Mobile'],
    var CountryCode : NSInteger?;
    var AreaCode : NSInteger?;
    var Number : NSInteger?;
    var Ext : NSInteger?;
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        Type <- map["Type"];
        CountryCode <- map["CountryCode"];
        AreaCode <- map["AreaCode"];
        Number <- map["Number"];
        Ext <- map["Ext"];
    }
}