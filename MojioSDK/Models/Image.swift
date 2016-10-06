//
//  Image.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class Image: Mappable {
    public dynamic var Src : String? = nil
    public dynamic var Normal : String? = nil
    public dynamic var Thumbnail : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }
    
    public func mapping(map: Map) {
        Src <- map["Src"];
        Normal <- map["Normal"];
        Thumbnail <- map["Thumbnail"];
    }
}
