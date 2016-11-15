//
//  Activity.swift
//  MojioSDK
//
//  Created by Narayan Sainaney on 2016-06-27.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation
import ObjectMapper

open class RootActivity : Activity {

    open dynamic var Actor : Activity? = nil
    open dynamic var Target : Activity? = nil
    open dynamic var Result : Activity? = nil
    open dynamic var Object : Activity? = nil

    public required convenience init?(map: Map) {
        self.init()
    }

    open override func mapping(map: Map) {
        super.mapping(map: map)
                
        Actor <- map["Actor"]
        Target <- map["Target"]
        Result <- map["Result"]
        Object <- map["Object"]
    }
}
