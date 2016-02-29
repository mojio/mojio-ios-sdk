//
//  Transmission.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Transmission: Object, Mappable {
    
    dynamic var Name : String? = nil
    dynamic var Type : String? = nil
    dynamic var DetailType : String? = nil
    dynamic var Gears : String? = nil

    required convenience init?(_ map: Map) {
        self.init();
    }
    
    func mapping(map: Map) {
        Name <- map["Name"]
        Type <- map["Type"]
        DetailType <- map["DetailType"]
        Gears <- map["Gears"]
    }

}
