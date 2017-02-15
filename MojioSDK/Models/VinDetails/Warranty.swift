//
//  Warranty.Swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class Warranty: Mappable {
    
    public dynamic var Name : String? = nil
    public dynamic var Type : String? = nil
    public dynamic var Months : String? = nil
    public dynamic var Km : Float = 0
    
    public required convenience init?(_ map: Map) {
        self.init();
    }
    
    public required init() {
        
    }

    public func mapping(map: Map) {
        Name <- map["Name"]
        Type <- map["Type"]
        Months <- map["Months"]
        Km <- map["Km"]
    }
}
