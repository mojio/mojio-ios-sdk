//
//  IdleState.swift
//  MojioSDK
//
//  Created by Suresh Venkatraman on 9/21/16.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class IdleState: Object, Mappable {
    
    public dynamic var Timestamp : String? = nil
    public dynamic var Value : Bool = false
    public dynamic var StartTime : String? = nil
    public dynamic var Duration : TimePeriod? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        Timestamp <- map["Timestamp"];
        Value <- map["Value"];
        StartTime <- map["StartTime"];
        Duration <- map["Duration"];
    }
    
}

