//
//  Heading.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class HeadingUnits : NSObject {
    open static let Degree : String = "Degree"
}

open class Heading: Mappable {
    
    open dynamic var BaseUnit : String? = nil
    open dynamic var Direction : String? = nil
    open dynamic var LeftTurn : Bool = false
    open dynamic var Timestamp : String? = nil
    open dynamic var BaseValue : Float = 0
    
    // HeadingUnits
    open dynamic var Unit : String? = nil
    open dynamic var Value : Float = 0
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    open func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"]
        Direction <- map["Direction"]
        LeftTurn <- map["LeftTurn"]
        Timestamp <- map["Timestamp"]
        BaseValue <- map["BaseValue"]
        Unit <- map["Unit"]
        Value <- map["Value"]
    }

}
