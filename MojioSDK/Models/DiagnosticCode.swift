//
//  DiagnosticCode.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class DiagnosticCode: Mappable {
    
    public dynamic var Code : String? = nil
    public dynamic var Description : String? = nil
    public dynamic var Timestamp : String? = nil
    
    // RiskSeverity
    public dynamic var Severity : String? = nil
    public dynamic var Instructions : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }
    
    public func mapping(map: Map) {
        Code <- map["Code"];
        Description <- map["Description"];
        Timestamp <- map["Timestamp"];
        Severity <- map["Severity"];
        Instructions <- map["Instructions"];
    }

}
