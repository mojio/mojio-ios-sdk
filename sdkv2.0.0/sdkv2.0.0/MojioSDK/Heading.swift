//
//  Heading.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Heading: Object, Mappable {
    
    dynamic var BaseUnit : NSString? = nil //['Degree']
    dynamic var Direction : NSString? = nil
    var LeftTurn = RealmOptional<Bool>()
    dynamic var Timestamp : NSString? = nil
    var BaseValue : Float = 0
    dynamic var Unit : NSString? = nil  // ['Degree']
    var Value : Float = 0
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"];
        Direction <- map["Direction"];
        LeftTurn <- map["LeftTurn"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }

}
