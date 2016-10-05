//
//  ServiceInterval.swift
//  Pods
//
//  Created by Ashish Agarwal on 2016-10-04.
//
//

import UIKit
import ObjectMapper
import RealmSwift

public class ServiceInterval: Mappable {
    
    public dynamic var OperatingParameter: String? = nil
    public dynamic var OperatingParameterNotes: String? = nil
    public dynamic var IntervalType: String? = nil
    public dynamic var Value: Float = 0
    public dynamic var Units: String? = nil
    public dynamic var InitalValue: Float = 0

    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        OperatingParameter <- map["OperatingParameter"]
        OperatingParameterNotes <- map["OperatingParameterNotes"]
        IntervalType <- map["IntervalType"]
        Value <- map["Value"]
        Units <- map["Units"]
        InitalValue <- map["InitalValue"]
    }


}
