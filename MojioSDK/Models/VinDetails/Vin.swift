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

public struct Vin: Mappable, PrimaryKey {
    
    public var VIN: String? = nil
    public var Timestamp: String? = nil
    public var Market: String? = nil
    public var Year: Int = 0
    public var Make: String? = nil
    public var Model: String? = nil
    public var VehicleType: String? = nil
    public var BodyType: String? = nil
    public var DriveType: String? = nil
    public var FuelTankSize: Double = 0
    public var EPAFuelEfficiency: Double = 0
    public var VehicleEngine: Engine? = nil
    public var VehicleTransmission: Transmission? = nil
    public var Warranties: [Warranty] = []
    public var Recalls: [Recall] = []
    public var ServiceBulletins: [ServiceBulletin] = []
    
    public var timestamp: Date? = nil

    public var Id: String? {
        return self.VIN
    }
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }
    
    public mutating func mapping(map: Map) {
        VIN <- map["VIN"]
        Timestamp <- map["Timestamp"]
        Market <- map["Market"]
        Year <- map["Year"]
        Make <- map["Make"]
        Model <- map["Model"]
        VehicleType <- map["VehicleType"]
        BodyType <- map["BodyType"]
        DriveType <- map["DriveType"]
        FuelTankSize <- map["FuelTankSize"]
        EPAFuelEfficiency <- map["EPAFuelEfficiency"]
        VehicleEngine <- map["Engine"]
        VehicleTransmission <- map["Transmission"]
        Warranties <- map["Warranties"]
        Recalls <- map["Recalls"]
        ServiceBulletins <- map["ServiceBulletins"]
        
        timestamp = self.Timestamp?.toDate
    }
}
