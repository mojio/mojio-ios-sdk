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

public class Email: Object, Mappable {
    public dynamic var Verified : Bool = false
    public dynamic var Address : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init();
    }
    
    public func mapping(map: Map) {
        self.Verified <- map["Verified"];
        self.Address <- map["Address"];
    }

}