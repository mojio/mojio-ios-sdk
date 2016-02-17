//
//  DiagnosticCode.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class DiagnosticCode: Object, Mappable {
    
    dynamic var Code : NSString? = nil
    dynamic var Description : NSString? = nil
    dynamic var Timestamp : NSString? = nil
    dynamic var Severity : NSString? = nil // ['Unknown', 'Low', 'Medium', 'High', 'None'],
    dynamic var Instructions : NSString? = nil
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        Code <- map["Code"];
        Description <- map["Description"];
        Timestamp <- map["Timestamp"];
        Severity <- map["Severity"];
        Instructions <- map["Instructions"];
    }

}
