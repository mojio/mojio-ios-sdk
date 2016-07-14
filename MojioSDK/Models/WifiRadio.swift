//
//  WifiRadio.swift
//  Pods
//
//  Created by Ashish Agarwal on 2016-06-27.
//
//

import UIKit
import ObjectMapper
import RealmSwift

public class WifiRadio: Object, Mappable  {
    
    public dynamic var TimeStamp : String? = nil
    public dynamic var SSID : String? = nil
    public dynamic var Password : String? = nil
    public dynamic var AllowRoaming : String? = nil
    public dynamic var Status : String? = nil //['Connected', 'Roaming', 'Disconnected']
    public dynamic var Strength : String? = nil

    public required convenience init?(_ map: Map) {
        self.init()
    }

    public func mapping (map : Map) {
        TimeStamp <- map["TimeStamp"]
        SSID <- map["SSID"]
        Password <- map["Password"]
        AllowRoaming <- map["AllowRoaming"]
        Status <- map["Status"]
        Strength <- map["Strength"]
    }

}
