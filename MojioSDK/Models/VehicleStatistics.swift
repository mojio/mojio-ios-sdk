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

public struct VehicleStatistics: Mappable {
    public var EstimatedFuelLevel: FuelLevel? = nil
    public var EstimatedFuelVolume: FuelVolume? = nil
    public var AverageFuelEfficiency: FuelEfficiency? = nil
    public var TotalRange: Distance? = nil
    public var CurrentRange: Distance? = nil
    public var LastFillUpDate: String? = nil
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }
    
    public mutating func mapping(map: Map) {
        EstimatedFuelLevel <- map["EstimatedFuelLevel"]
        EstimatedFuelVolume <- map["EstimatedFuelVolume"]
        AverageFuelEfficiency <- map["AverageFuelEfficiency"]
        TotalRange <- map["TotalRange"]
        CurrentRange <- map["CurrentRange"]
        LastFillUpDate <- map["LastFillUpDate"]
    }
}
