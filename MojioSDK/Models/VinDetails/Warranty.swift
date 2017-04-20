//
//  Warranty.Swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class Warranty: Mappable {
    
    open dynamic var Name : String? = nil
    open dynamic var `Type` : String? = nil
    open dynamic var Months : String? = nil
    open dynamic var Km : String? = nil
    
    public required convenience init?(map: Map) {
        self.init();
    }
    
    public required init() {
        
    }

    open func mapping(map: Map) {
        Name <- map["Name"]
        Type <- map["Type"]
        Months <- map["Months"]
        Km <- map["Km"]
    }
}
