//
//  Odometer.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class Odometer: Object, Mappable {
    
    public dynamic var RolloverValue : Float = 0
    public dynamic var BaseUnit : String? = nil
    public dynamic var Timestamp : String? = nil
    public dynamic var BaseValue : Float = 0
    
    // DistanceUnits
    public dynamic var Unit : String? = nil
    public dynamic var Value : Float = 0
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func jsonDict () -> NSDictionary {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Unit != nil {
            dictionary.setObject(self.Unit!, forKey: "Unit")
        }
        
        dictionary.setObject(self.Value, forKey: "Value")
        
        return dictionary
    }
    
    public func mapping(map: Map) {
        RolloverValue <- map["RolloverValue"];
        BaseUnit <- map["BaseUnit"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }
}
