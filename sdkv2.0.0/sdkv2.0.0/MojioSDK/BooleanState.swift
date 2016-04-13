//
//  BooleanState.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class BooleanState: Object, Mappable {
    
    dynamic var Timestamp : NSString? = nil
    dynamic  var Value : Bool = false
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        Timestamp <- map["Timestamp"];
        Value <- map["Value"];
    }
    
}
