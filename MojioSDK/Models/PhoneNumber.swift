//
//  PhoneNumber.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Realm

public class PhoneNumberTypes : NSObject {
    public static let Home : String = "Home"
    public static let Work : String = "Work"
    public static let Mobile : String = "Mobile"
}

public class PhoneNumber : Object, Mappable {

    // PhoneNumberTypes
    public dynamic var Type : String? = nil
    public dynamic var CountryCode : Int = 0
    public dynamic var AreaCode : Int = 0
    public dynamic var Number : Int = 0
    public dynamic var Ext : Int = 0
    
    public required convenience init?(_ map: Map) {
        self.init();
    }
    
    public func mapping(map: Map) {
        Type <- map["Type"];
        CountryCode <- map["CountryCode"];
        AreaCode <- map["AreaCode"];
        Number <- map["Number"];
        Ext <- map["Ext"];
    }
}