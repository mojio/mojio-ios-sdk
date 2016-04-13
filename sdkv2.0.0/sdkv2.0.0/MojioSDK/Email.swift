//
//  Email.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Email: Object, Mappable {
    dynamic var Verified : Bool = false
    dynamic var Address : String? = nil
    
    required convenience init?(_ map: Map) {
        self.init();
    }
    
    func mapping(map: Map) {
        self.Verified <- map["Verified"];
        self.Address <- map["Address"];
    }

}