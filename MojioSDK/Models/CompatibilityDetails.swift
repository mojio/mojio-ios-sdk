//
//  CompatibilityDetails.swift
//  MojioSDK
//
//  Created by Suresh Venkatraman on 3/20/17.
//  Copyright © 2017 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class VehicleCompatibilityLevel: NSObject {
    public static let Full : String = "Full"
    public static let Partial : String = "Partial"
    public static let Minimum : String = "Minimum"
    public static let NotCompatible : String = "NotCompatible"
    public static let Unknown : String = "Unknown"
}

public class CompatibilityDetails: Mappable {
    
    public dynamic var Level: String? = nil
    public dynamic var Changed : Bool = false
    public dynamic var LastChecked : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }
    
    public func mapping(map: Map) {
        Level <- map["Level"]
        Changed <- map["Changed"]
        LastChecked <- map["LastChecked"]
    }
}
