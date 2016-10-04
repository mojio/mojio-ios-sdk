//
//  ServiceInterval.swift
//  MojioSDK
//
//  Created by Oleksii Lubianyi on 10/4/16.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class ServiceInterval: Object, Mappable {
    
    public dynamic var OperatingParameter : String? = nil
    public dynamic var OperatingParameterNotes : String? = nil
    public dynamic var Units : String? = nil
    public dynamic var Value : Float = 0
    public dynamic var InitialValue : Float = 0
    public dynamic var IntervalType : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init();
    }
    
    public func mapping(map: Map) {
        
        OperatingParameter <- map["OperatingParameter"]
        OperatingParameterNotes <- map["OperatingParameterNotes"]
        Units <- map["Units"]
        Value <- map["Value"]
        InitialValue <- map["InitialValue"]
        IntervalType <- map["IntervalType"]
    }
}
