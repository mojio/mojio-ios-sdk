//
//  ServiceInterval.swift
//  Pods
//
//  Created by Ashish Agarwal on 2016-10-04.
//
//

import UIKit
import ObjectMapper

open class ServiceInterval: Mappable {
    
    open dynamic var OperatingParameter: String? = nil
    open dynamic var OperatingParameterNotes: String? = nil
    open dynamic var IntervalType: String? = nil
    open dynamic var Value: Float = 0
    open dynamic var Units: String? = nil
    open dynamic var InitalValue: Float = 0

    public required convenience init?(map: Map) {
        self.init()
    }
    
    open func mapping(map: Map) {
        OperatingParameter <- map["OperatingParameter"]
        OperatingParameterNotes <- map["OperatingParameterNotes"]
        IntervalType <- map["IntervalType"]
        Value <- map["Value"]
        Units <- map["Units"]
        InitalValue <- map["InitalValue"]
    }


}
