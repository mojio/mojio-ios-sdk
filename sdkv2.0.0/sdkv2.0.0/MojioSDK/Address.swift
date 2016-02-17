//
//  Address.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Address: Object, Mappable {
    
    dynamic var HouseNumber : NSString? = nil
    dynamic var Road : NSString? = nil
    dynamic var Neighbourhood : NSString? = nil
    dynamic var Suburb : NSString? = nil
    dynamic var City : NSString? = nil
    dynamic var County : NSString? = nil
    dynamic var State : NSString? = nil
    dynamic var PostCode : NSString? = nil
    dynamic var Country : NSString? = nil
    dynamic var CountryCode : NSString? = nil
    dynamic var FormattedAddress : NSString? = nil
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        HouseNumber <- map["HouseNumber"];
        Road <- map["Road"];
        Neighbourhood <- map["Neighbourhood"];
        Suburb <- map["Suburb"];
        City <- map["City"];
        County <- map["County"];
        State <- map["State"];
        PostCode <- map["PostCode"];
        Country <- map["Country"];
        CountryCode <- map["CountryCode"];
        FormattedAddress <- map["FormattedAddress"];
    }

}
