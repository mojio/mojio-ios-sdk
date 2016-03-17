//
//  Duration.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Duration: Object, Mappable {
    
    dynamic var BaseUnit : NSString? = nil //['Ticks', 'Milliseconds', 'Seconds', 'Minutes', 'Hours', 'Days', 'Weeks']
    dynamic var Timestamp : NSString? = nil
    dynamic var BaseValue : Float = 0
    dynamic var Unit : NSString? = nil  // ['Ticks', 'Milliseconds', 'Seconds', 'Minutes', 'Hours', 'Days', 'Weeks']
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
