//
//  RPM.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class RPM: Object, Mappable {
    
    dynamic var BaseUnit : NSString? = nil //['RevolutionsPerMinute'],
    dynamic var Timestamp : NSString? = nil
    dynamic var BaseValue : Float = 0
    dynamic var Unit : NSString? = nil  //['RevolutionsPerMinute'],
    dynamic var Value : Float = 0
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }

}
