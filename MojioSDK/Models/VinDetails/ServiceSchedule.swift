//
//  ServiceSchedule.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class ServiceSchedule: Mappable {
    
    public dynamic var VIN : String? = nil
    public var Items : [ServiceScheduleItem] = []
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        VIN <- map["VIN"]
        Items <- map["Items"]
    }
}
