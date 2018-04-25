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

//import UIKit
import Foundation

public struct VinDetails: Codable {
    
    public var Timestamp: String? = nil
    public var Vin: String? = nil
    public var Year: Int = 0
    public var Make: String? = nil
    public var Model: String? = nil
    public var Engine: String? = nil
    public var Cylinders: Int? = nil
    public var TotalFuelCapacity: FuelCapacity? = nil
    public var FuelType: String? = nil
    public var CityFuelEfficiency: Double = 0
    public var HighwayFuelEfficiency: Double = 0
    public var CombinedFuelEfficiency: Double = 0
    public var Transmission: String? = nil
    public var Message: String? = nil
    public var Success: Bool? = nil
    
    //public var timestamp: Date? = nil
}

extension VinDetails {
    
    public var timestamp: Date? {
        return self.Timestamp?.toDate
    }
}

//public init() {}
//
//public init?(map: Map) {
//    self.init()
//}
//
//public mutating func mapping(map: Map) {
//    Timestamp <- map["Timestamp"]
//    Vin <- map["Vin"]
//    Year <- map["Year"]
//    Make <- map["Make"]
//    Model <- map["Model"]
//    Engine <- map["Engine"]
//    Cylinders <- map["Cylinders"]
//    TotalFuelCapacity <- map["TotalFuelCapacity"]
//    FuelType <- map["FuelType"]
//    CityFuelEfficiency <- map["CityFuelEfficiency"]
//    HighwayFuelEfficiency <- map["HighwayFuelEfficiency"]
//    CombinedFuelEfficiency <- map["CombinedFuelEfficiency"]
//    Transmission <- map["Transmission"]
//    Message <- map["Message"]
//    Success <- map["Success"]
//
//    timestamp = self.Timestamp?.toDate
//}
