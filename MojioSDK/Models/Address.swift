//
//  Address.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class Address: Mappable {
    
    public dynamic var HouseNumber : String? = nil
    public dynamic var Road : String? = nil
    public dynamic var Neighbourhood : String? = nil
    public dynamic var Suburb : String? = nil
    public dynamic var City : String? = nil
    public dynamic var County : String? = nil
    public dynamic var State : String? = nil
    public dynamic var PostCode : String? = nil
    public dynamic var Country : String? = nil
    public dynamic var CountryCode : String? = nil
    public dynamic var FormattedAddress : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }
    
    public func mapping(map: Map) {
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
