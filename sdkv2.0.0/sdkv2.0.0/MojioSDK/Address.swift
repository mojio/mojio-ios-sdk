//
//  Address.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class Address: Mappable {
    
    var HouseNumber : NSString?;
    var Road : NSString?;
    var Neighbourhood : NSString?;
    var Suburb : NSString?;
    var City : NSString?;
    var County : NSString?;
    var State : NSString?;
    var PostCode : NSString?;
    var Country : NSString?;
    var CountryCode : NSString?;
    var FormattedAddress : NSString?;
    
    required init?(_ map: Map) {
        
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
