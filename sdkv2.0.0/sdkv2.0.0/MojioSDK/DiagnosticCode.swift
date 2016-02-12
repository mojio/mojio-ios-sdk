//
//  DiagnosticCode.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class DiagnosticCode: Mappable {
    
    var Code : NSString?;
    var Description : NSString?;
    var Timestamp : NSString?;
    var Severity : NSString?; // ['Unknown', 'Low', 'Medium', 'High', 'None'],
    var Instructions : NSString?;
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        Code <- map["Code"];
        Description <- map["Description"];
        Timestamp <- map["Timestamp"];
        Severity <- map["Severity"];
        Instructions <- map["Instructions"];
    }

}
