//
//  Warranty.Swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Warranty: Object, Mappable {
    
    dynamic var Name : String? = nil
    dynamic var Type : String? = nil
    dynamic var Months : String? = nil
    dynamic var Km : String? = nil
    
    required convenience init?(_ map: Map) {
        self.init();
    }
    
    func mapping(map: Map) {
        Name <- map["Name"]
        Type <- map["Type"]
        Months <- map["Months"]
        Km <- map["Km"]
    }
    
}
