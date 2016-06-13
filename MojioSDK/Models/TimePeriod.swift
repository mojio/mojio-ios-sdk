//
//  TimePeriod.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class TimePeriodUnits : NSObject {
    public static let Ticks : String = "Ticks"
    public static let Milliseconds : String = "Milliseconds"
    public static let Seconds : String = "Seconds"
    public static let Minutes : String = "Minutes"
    public static let Hours : String = "Hours"
    public static let Days : String = "Days"
    public static let Weeks : String = "Weeks"
    public static let Months : String = "Months"
    public static let Years : String = "Years"
}

public class TimePeriod: Object, Mappable {
    
    public dynamic var BaseUnit : String? = nil
    public dynamic var Timestamp : String? = nil
    public dynamic var BaseValue : Float = 0
    
    // TimePeriodUnits
    public dynamic var Unit : String? = nil
    public dynamic var Value : Float = 0
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }

}
