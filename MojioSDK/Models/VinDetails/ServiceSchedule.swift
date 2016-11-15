//
//  ServiceSchedule.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class ServiceSchedule: Mappable {
    
    open dynamic var VIN : String? = nil
    open var Items : [ServiceScheduleItem] = []
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    open func mapping(map: Map) {
        VIN <- map["VIN"]
        Items <- map["Items"]
    }
}
