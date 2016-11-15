//
//  Address.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class Address: Mappable {
    
    open dynamic var HouseNumber : String? = nil
    open dynamic var Road : String? = nil
    open dynamic var Neighbourhood : String? = nil
    open dynamic var Suburb : String? = nil
    open dynamic var City : String? = nil
    open dynamic var County : String? = nil
    open dynamic var State : String? = nil
    open dynamic var PostCode : String? = nil
    open dynamic var Country : String? = nil
    open dynamic var CountryCode : String? = nil
    open dynamic var FormattedAddress : String? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {
        
    }
    
    open func mapping(map: Map) {
        HouseNumber <- map["HouseNumber"]
        Road <- map["Road"]
        Neighbourhood <- map["Neighbourhood"]
        Suburb <- map["Suburb"]
        City <- map["City"]
        County <- map["County"]
        State <- map["State"]
        PostCode <- map["PostCode"]
        Country <- map["Country"]
        CountryCode <- map["CountryCode"]
        FormattedAddress <- map["FormattedAddress"]
    }

}
