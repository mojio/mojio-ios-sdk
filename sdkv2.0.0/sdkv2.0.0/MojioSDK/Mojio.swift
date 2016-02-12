//
//  Mojio.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class Mojio: Mappable {
    var Name : String?;
    var IMEI : String?;
    var LastContactTime : String?;
    var GatewayTime : String?;
    var VehicleId : String?;
    var Tags : NSArray?;
    var Id : String?;
    var CreatedOn : String?;
    var LastModified : String?;

    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        Name <- map["Name"];
        IMEI <- map["IMEI"];
        LastContactTime <- map["LastContactTime"];
        GatewayTime <- map["GatewayTime"];
        VehicleId <- map["VehicleId"];
        Tags <- map["Tags"];
        Id <- map["Id"];
        CreatedOn <- map["CreatedOn"];
        LastModified <- map["LastModified"];
    }
}
