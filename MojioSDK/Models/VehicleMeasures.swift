//
//  VehicleMeasures.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-03-04.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class VehicleMeasures: Mappable {
    
    public var VehicleAcceleration : Acceleration? = nil
    public var VehicleAccelerometer : Accelerometer? = nil
    public var AccidentState : BooleanState? = nil
    public var VehicleBattery : Battery? = nil
    public dynamic var CurrentTrip : String? = nil
    public var Deceleration : Acceleration? = nil
    public var DiagnosticCodes : [DiagnosticCode] = []
    public var VehicleFuelEfficiency : FuelEfficiency? = nil
    
    // FuelEfficiencyCalculationMethod
    public dynamic var FuelEfficiencyCalculationMethod : String? = nil// ['Query', 'EngineFuelRate', 'MassAirFlow', 'Calculated', 'None'],
    public var VehicleFuelLevel : FuelLevel? = nil
    public var VehicleFuelVolume : FuelVolume? = nil

    // FuelType
    public dynamic var FuelType : String? = nil
    public dynamic var GatewayTime : String? = nil
    public var HarshEventState : HarshEvent? = nil
    public var VehicleHeading : Heading? = nil
    public var VehicleIdleState : IdleState? = nil
    public var IgnitionState : BooleanState? = nil
    public var VehicleLocation : Location? = nil
    public var MilStatus : Bool? = nil
    public dynamic var MojioId : String? = nil
    public var ParkedState : BooleanState? = nil
    public var VehicleRPM : RPM? = nil
    public var VehicleSpeed : Speed? = nil
    public var TowState : BooleanState? = nil
    public var VIN : String? = nil
    public var VehicleVinDetails : VinDetails? = nil
    public var VirtualOdometer : Odometer? = nil
    public var VehicleOdometer : Odometer? = nil
    public dynamic var Time : String? = nil
    public var DisturbanceState : BooleanState? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {}

    public func mapping(map: Map) {
        VehicleAcceleration <- map["Acceleration"]
        VehicleAccelerometer <- map["Accelerometer"]
        AccidentState <- map["AccidentState"]
        DiagnosticCodes <- map ["DiagnosticCodes"]
        VehicleBattery <- map["Battery"]
        CurrentTrip <- map["CurrentTrip"]
        Deceleration <- map["Deceleration"]
        VehicleFuelEfficiency <- map["FuelEfficiency"]
        FuelEfficiencyCalculationMethod <- map["FuelEfficiencyCalculationMethod"]
        VehicleFuelLevel <- map["FuelLevel"]
        VehicleFuelVolume <- map["FuelVolume"]
        FuelType <- map["FuelType"]
        GatewayTime <- map["GatewayTime"]
        HarshEventState <- map["HarshEventState"]
        VehicleHeading <- map["Heading"]
        VehicleIdleState <- map["IdleState"]
        IgnitionState <- map["IgnitionState"]
        VehicleLocation <- map["Location"]
        MilStatus <- map["MilStatus"]
        MojioId <- map["MojioId"]
        ParkedState <- map["ParkedState"]
        VehicleRPM <- map["RPM"]
        VehicleSpeed <- map["Speed"]
        TowState <- map["TowState"]
        VIN <- map["VIN"]
        VehicleVinDetails <- map["VinDetails"]
        VirtualOdometer <- map["VirtualOdometer"]
        VehicleOdometer <- map["Odometer"]
        Time <- map["Time"]
    }
}
