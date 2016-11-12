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
    
    public dynamic var Ignored : Bool = false
    public dynamic var Code : String? = nil
    public dynamic var Description : String? = nil
    public dynamic var Timestamp : String? = nil
    
    // RiskSeverity
    public dynamic var Severity : String? = nil
    public dynamic var Instructions : String? = nil
    
    // Type
    public dynamic var StateType : String? = nil
    public dynamic var Type : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }
    
    public func jsonIgnoredDict () -> NSDictionary {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        dictionary.setObject(self.Ignored, forKey: "Ignored")
        return dictionary
    }
    
    public func mapping(map: Map) {
        Ignored <- map["Ignored"];
        Code <- map["Code"];
        Description <- map["Description"];
        Timestamp <- map["Timestamp"];
        Severity <- map["Severity"];
        Instructions <- map["Instructions"];
        StateType <- map["StateType"];
        Type <- map["Type"];
    }

}
