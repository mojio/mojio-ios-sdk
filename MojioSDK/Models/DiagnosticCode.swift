//
//  DiagnosticCode.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class DiagnosticCode: Mappable {
    
    open dynamic var Ignored : Bool = false
    open dynamic var Code : String? = nil
    open dynamic var Description : String? = nil
    open dynamic var Timestamp : String? = nil
    
    // RiskSeverity
    open dynamic var Severity : String? = nil
    open dynamic var Instructions : String? = nil
    
    // Type
    open dynamic var StateType : String? = nil
    open dynamic var DiagnosticCodeType : String? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {
        
    }
    
    open func jsonIgnoredDict () -> NSDictionary {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        dictionary.setObject(self.Ignored, forKey: "Ignored" as NSCopying)
        return dictionary
    }
    
    open func mapping(map: Map) {
        Ignored <- map["Ignored"];
        Code <- map["Code"];
        Description <- map["Description"];
        Timestamp <- map["Timestamp"];
        Severity <- map["Severity"];
        Instructions <- map["Instructions"];
        StateType <- map["StateType"];
        DiagnosticCodeType <- map["Type"];
    }

}
