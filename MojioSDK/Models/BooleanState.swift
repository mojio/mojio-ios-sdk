//
//  BooleanState.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class BooleanState: Object, Mappable {
    
    public dynamic var Timestamp : String? = nil
    public dynamic var Value : Bool = false
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        Timestamp <- map["Timestamp"];
        Value <- map["Value"];
    }
    
}
