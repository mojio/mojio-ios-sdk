//
//  VehicleMeasures.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-03-04.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class VehicleMeasures: Mappable {
    
    open var VehicleAcceleration : Acceleration? = nil
    open var VehicleAccelerometer : Accelerometer? = nil
    open var AccidentState : BooleanState? = nil
    open var VehicleBattery : Battery? = nil
    open dynamic var CurrentTrip : String? = nil
    open var Deceleration : Acceleration? = nil
    open var DiagnosticCodes : [DiagnosticCode] = []
    open var VehicleFuelEfficiency : FuelEfficiency? = nil
    
    // FuelEfficiencyCalculationMethod
    open dynamic var FuelEfficiencyCalculationMethod : String? = nil// ['Query', 'EngineFuelRate', 'MassAirFlow', 'Calculated', 'None'],
    open var VehicleFuelLevel : FuelLevel? = nil
    open var VehicleFuelVolume : FuelVolume? = nil

    // FuelType
    open dynamic var FuelType : String? = nil
    open dynamic var GatewayTime : String? = nil
    open var HarshEventState : HarshEvent? = nil
    open var VehicleHeading : Heading? = nil
    open var VehicleIdleState : IdleState? = nil
    open var IgnitionState : BooleanState? = nil
    open var VehicleLocation : Location? = nil
    open var MilStatus : Bool? = nil
    open dynamic var MojioId : String? = nil
    open var ParkedState : BooleanState? = nil
    open var VehicleRPM : RPM? = nil
    open var VehicleSpeed : Speed? = nil
    open var TowState : BooleanState? = nil
    open var VIN : String? = nil
    open var VehicleVinDetails : VinDetails? = nil
    open var VirtualOdometer : Odometer? = nil
    open var VehicleOdometer : Odometer? = nil
    open dynamic var Time : String? = nil
    open var DisturbanceState : BooleanState? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {}

    open func mapping(map: Map) {
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
