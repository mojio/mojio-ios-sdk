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
    
    public var EstimatedFuelLevel : VehicleRiskSeverityStaticsItem? = nil
    public var EstimatedFuelVolume : VehicleStaticsItem? = nil
    public var AverageFuelEfficiency : VehicleStaticsItem? = nil
    public var TotalRange : VehicleStaticsItem? = nil
    public var CurrentRange : VehicleStaticsItem? = nil
    
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

public class VehicleStaticsItem: Mappable {
    
    public dynamic var BaseUnit : String? = nil
    public dynamic var Timestamp : String? = nil
    public dynamic var BaseValue : Float = 0
    public dynamic var Unit : String? = nil
    public dynamic var Value : Float = 0
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }
    
    public func mapping(map: Map) {
        BaseUnit <- map["BaseUnit"]
        Timestamp <- map["Timestamp"]
        BaseValue <- map["BaseValue"]
        Unit <- map["Unit"]
        Value <- map["Value"]
    }
    
}

public class VehicleRiskSeverityStaticsItem: VehicleStaticsItem {
    
    public dynamic var RiskSeverity : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        super.init()
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        RiskSeverity <- map["RiskSeverity"]
    }
    
}
