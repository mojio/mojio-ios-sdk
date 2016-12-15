//
//  Activity.swift
//  MojioSDK
//
//  Created by Narayan Sainaney on 2016-06-27.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation
import ObjectMapper

public class RootActivity : Activity {

    public dynamic var Actor : Activity? = nil
    public dynamic var Target : Activity? = nil
    public dynamic var Result : Activity? = nil
    public dynamic var Object : Activity? = nil
    public dynamic var Origin : Activity? = nil

    public required convenience init?(_ map: Map) {
        self.init()
    }

    public override func mapping(map: Map) {
        super.mapping(map)
                
        Actor <- map["Actor"]
        Target <- map["Target"]
        Result <- map["Result"]
        Object <- map["Object"]
        Origin <- map["Origin"]
    }
}
