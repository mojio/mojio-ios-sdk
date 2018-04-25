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

public struct Engine: Codable {
    
    public var Name: String? = nil
    public var Cylinders: String? = nil
    public var Displacement: Double = 0
    public var FuelInduction: String? = nil
    public var FuelQuality: String? = nil
    public var FuelType: String? = nil
    public var MaxHp: String? = nil
    public var MaxHpAt: String? = nil
}

//public init() {}
//
//public init?(map: Map) {
//    self.init()
//}
//
//public mutating func mapping(map: Map) {
//    Name <- map["Name"]
//    Cylinders <- map["Cylinders"]
//    Displacement <- map["Displacement"]
//    FuelInduction <- map["FuelInduction"]
//    FuelQuality <- map["FuelQuality"]
//    FuelType <- map["FuelType"]
//    MaxHp <- map["MaxHp"]
//    MaxHpAt <- map["MaxHpAt"]
//}
