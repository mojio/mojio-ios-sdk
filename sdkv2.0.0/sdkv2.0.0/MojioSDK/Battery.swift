//
//  Battery.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class Battery: Mappable {
    
    var Connected : Bool?;
    var RiskSeverity : NSString?; //['Unknown', 'Low', 'Medium', 'High', 'None'],
    var LowVoltageDuration : Duration?;
    var HighVoltageDuration : Duration?;
    var BaseUnit : NSString?; // ['MilliVolts', 'Volts'],
    var Timestamp : NSString?;
    var BaseValue : NSNumber?;
    var Unit : NSString?; // ['MilliVolts', 'Volts'],
    var Value : NSNumber?;
    
    required init?(_ map: Map) {
        
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
