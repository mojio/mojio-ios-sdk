//
//  VehicleStatistics.swift
//  Pods
//
//  Created by Oleksandr Kiporenko on 10/7/16.
//
//

import UIKit
import ObjectMapper

public class VehicleStatistics: Mappable {
    
    public var EstimatedFuelLevel : FuelLevel? = nil
    public var EstimatedFuelVolume : FuelVolume? = nil
    public var AverageFuelEfficiency : FuelEfficiency? = nil
    public var TotalRange : Distance? = nil
    public var CurrentRange : Distance? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }
    
    public func mapping(map: Map) {
        EstimatedFuelLevel <- map["EstimatedFuelLevel"]
        EstimatedFuelVolume <- map["EstimatedFuelVolume"]
        AverageFuelEfficiency <- map["AverageFuelEfficiency"]
        TotalRange <- map["TotalRange"]
        CurrentRange <- map["CurrentRange"]
    }

}
