//
//  Image.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class Image: Mappable {
    var Src : String?;
    var Normal : String?;
    var Thumbnail : String?;
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        Src <- map["Src"];
        Normal <- map["Normal"];
        Thumbnail <- map["Thumbnail"];
    }
}
