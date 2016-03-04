//
//  Image.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Image: Object, Mappable {
    dynamic var Src : String? = nil
    dynamic var Normal : String? = nil
    dynamic var Thumbnail : String? = nil
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        Src <- map["Src"];
        Normal <- map["Normal"];
        Thumbnail <- map["Thumbnail"];
    }
}
