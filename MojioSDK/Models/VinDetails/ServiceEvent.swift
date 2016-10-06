//
//  ServiceEvent.swift
//  Pods
//
//  Created by Ashish Agarwal on 2016-10-04.
//
//

import UIKit
import ObjectMapper
import RealmSwift

public class ServiceEvent: Mappable {
    
    public dynamic var ComputerCode: String? = nil
    public dynamic var Event: String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        ComputerCode <- map["ComputerCode"]
        Event <- map["Event"]
    }


}
