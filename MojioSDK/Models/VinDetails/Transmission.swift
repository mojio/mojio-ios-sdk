//
//  Transmission.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class Transmission: Mappable {
    
    open dynamic var Name : String? = nil
    open dynamic var TransmissionType : String? = nil
    open dynamic var DetailType : String? = nil
    open dynamic var Gears : String? = nil

    public required convenience init?(map: Map) {
        self.init();
    }
    
    public required init() {
        
    }

    open func mapping(map: Map) {
        Name <- map["Name"]
        TransmissionType <- map["Type"]
        DetailType <- map["DetailType"]
        Gears <- map["Gears"]
    }

}
