/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2017 Copyright Moj.io Inc.
 * All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains, the property of
 * Moj.io Inc. and its suppliers, if any.  The intellectual and technical
 * concepts contained herein are proprietary to Moj.io Inc. and its suppliers
 * and may be covered by Patents, pending patents, and are protected by trade
 * secret or copyright law.
 *
 * Dissemination of this information or reproduction of this material is strictly
 * forbidden unless prior written permission is obtained from Moj.io Inc.
 *******************************************************************************/

import UIKit
import ObjectMapper


public struct Mojio: Mappable, PrimaryKey {
    public var Id: String? = nil
    public var Name: String? = nil
    public var IMEI: String? = nil
    public var LastContactTime: String? = nil
    public var GatewayTime: String? = nil
    public var VehicleId: String? = nil
    public var MojioLocation: Location? = nil
    public var Tags: [String] = []
    public var Wifi: WifiRadio? = nil
    public var ConnectedState: BooleanState? = nil
    public var CreatedOn: String? = nil
    public var LastModified: String? = nil
    public var Deleted: Bool = false
    public var MSISDN: String? = nil
    public var ICCID: String? = nil
    
    // Date Values
    public var lastContactTime: Date? = nil
    public var gatewayTime: Date? = nil
    public var createdOn: Date? = nil
    public var lastModified: Date? = nil
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }
    
    public func json () -> String? {
        var map: [String: Any] = [:]
        
        if let name = self.Name {
            map["Name"] = name
        }

        if let imei = self.IMEI {
            map["IMEI"] = imei
        }
        
        let data = try! JSONSerialization.data(withJSONObject: map, options:  JSONSerialization.WritingOptions.prettyPrinted)
        return String(data: data, encoding: String.Encoding.utf8)
        
    }
    
    public mutating func mapping(map: Map) {
        Id <- map["Id"]
        Name <- map["Name"]
        IMEI <- map["IMEI"]
        LastContactTime <- map["LastContactTime"]
        Wifi <- map["WifiRadio"]
        GatewayTime <- map["GatewayTime"]
        VehicleId <- map["VehicleId"]
        MojioLocation <- map["Location"]
        ConnectedState <- map["ConnectedState"]
        CreatedOn <- map["CreatedOn"]
        LastModified <- map["LastModified"]
        Tags <- map["Tags"]
        Deleted <- map["Deleted"]
        MSISDN <- map["MSISDN"]
        ICCID <- map["ICCID"]
        
        // Date Values
        lastContactTime = self.LastContactTime?.toDate
        gatewayTime = self.GatewayTime?.toDate
        createdOn = self.CreatedOn?.toDate
        lastModified = self.LastModified?.toDate
    }
}
