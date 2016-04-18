//
//  Address.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class Address: Object, Mappable {
    
    public dynamic var HouseNumber : NSString? = nil
    public dynamic var Road : NSString? = nil
    public dynamic var Neighbourhood : NSString? = nil
    public dynamic var Suburb : NSString? = nil
    public dynamic var City : NSString? = nil
    public dynamic var County : NSString? = nil
    public dynamic var State : NSString? = nil
    public dynamic var PostCode : NSString? = nil
    public dynamic var Country : NSString? = nil
    public dynamic var CountryCode : NSString? = nil
    public dynamic var FormattedAddress : NSString? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
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
