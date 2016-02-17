//
//  Battery.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Battery: Object, Mappable {
    
    var Connected = RealmOptional<Bool>()
    dynamic var RiskSeverity : NSString? = nil //['Unknown', 'Low', 'Medium', 'High', 'None'],
    dynamic var LowVoltageDuration : Duration? = nil
    dynamic var HighVoltageDuration : Duration? = nil
    dynamic var BaseUnit : NSString? = nil // ['MilliVolts', 'Volts'],
    dynamic var Timestamp : NSString? = nil
    var BaseValue : Float = 0
    dynamic var Unit : NSString? // ['MilliVolts', 'Volts'],
    var Value : Float = 0
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        Connected <- map["Connected"];
        RiskSeverity <- map["RiskSeverity"];
        LowVoltageDuration <- map["LowVoltageDuration"];
        HighVoltageDuration <- map["HighVoltageDuration"];
        BaseUnit <- map["BaseUnit"];
        Timestamp <- map["Timestamp"];
        BaseValue <- map["BaseValue"];
        Unit <- map["Unit"];
        Value <- map["Value"];
    }

}
