//
//  VehicleStatistics.swift
//  Pods
//
//  Created by Oleksandr Kiporenko on 10/7/16.
//
//

import UIKit
import ObjectMapper

open class VehicleStatistics: Mappable {
    
    open var EstimatedFuelLevel : FuelLevel? = nil
    open var EstimatedFuelVolume : FuelVolume? = nil
    open var AverageFuelEfficiency : FuelEfficiency? = nil
    open var TotalRange : Distance? = nil
    open var CurrentRange : Distance? = nil
    open dynamic var LastFillUpDate : String? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {
        
    }
    
    open func mapping(map: Map) {
        EstimatedFuelLevel <- map["EstimatedFuelLevel"]
        EstimatedFuelVolume <- map["EstimatedFuelVolume"]
        AverageFuelEfficiency <- map["AverageFuelEfficiency"]
        TotalRange <- map["TotalRange"]
        CurrentRange <- map["CurrentRange"]
        LastFillUpDate <- map["LastFillUpDate"]
    }

}
