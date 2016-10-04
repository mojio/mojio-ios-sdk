//
//  FuelVolume.swift
//  MojioSDK
//
//  Created by Oleksii Lubianyi on 9/30/16.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class FuelVolumeUnits : NSObject {
    public static let Gallon        : String = "Gallon"
    public static let Liter         : String = "Liter"
    public static let Gill          : String = "Gill"
    public static let Pint          : String = "Pint"
    public static let Quart         : String = "Quart"
    public static let Milliliter    : String = "Milliliter"
}

public class FuelVolume: Object, Mappable {

    public dynamic var BaseUnit : String? = nil
    public dynamic var Timestamp : String? = nil
    public dynamic var BaseValue : Float = 0
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
