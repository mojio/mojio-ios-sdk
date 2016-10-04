//
//  ServiceEvent.swift
//  MojioSDK
//
//  Created by Oleksii Lubianyi on 10/4/16.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class ServiceEvent: Object, Mappable {
    
    public dynamic var ComputerCode : String? = nil
    public dynamic var Event : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init();
    }
    
    public func mapping(map: Map) {
        
        ComputerCode <- map["ComputerCode"]
        Event <- map["Event"]
    }
}
