//
//  Image.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class Image: Mappable {
    open dynamic var Src : String? = nil
    open dynamic var Normal : String? = nil
    open dynamic var Thumbnail : String? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {
        
    }
    
    open func mapping(map: Map) {
        Src <- map["Src"];
        Normal <- map["Normal"];
        Thumbnail <- map["Thumbnail"];
    }
}
