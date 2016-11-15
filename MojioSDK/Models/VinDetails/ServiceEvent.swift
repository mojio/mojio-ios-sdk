//
//  ServiceEvent.swift
//  Pods
//
//  Created by Ashish Agarwal on 2016-10-04.
//
//

import UIKit
import ObjectMapper

open class ServiceEvent: Mappable {
    
    open dynamic var ComputerCode: String? = nil
    open dynamic var Event: String? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    open func mapping(map: Map) {
        ComputerCode <- map["ComputerCode"]
        Event <- map["Event"]
    }


}
