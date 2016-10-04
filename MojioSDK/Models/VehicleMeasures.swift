//
//  VehicleMeasures.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-03-04.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class VehicleMeasures: Object, Mappable {
    
    public dynamic var VehicleAcceleration : Acceleration? = nil
    public dynamic var VehicleAccelerometer : Accelerometer? = nil
    public dynamic var AccidentState : BooleanState? = nil
    public dynamic var VehicleBattery : Battery? = nil
    public dynamic var CurrentTrip : String? = nil
    public dynamic var Deceleration : Acceleration? = nil
    public var DiagnosticCodes = List<DiagnosticCode>()
    public dynamic var VehicleFuelEfficiency : FuelEfficiency? = nil
    
    // FuelEfficiencyCalculationMethod
    public dynamic var FuelEfficiencyCalculationMethod : String? = nil// ['Query', 'EngineFuelRate', 'MassAirFlow', 'Calculated', 'None'],
    public dynamic var VehicleFuelLevel : FuelLevel? = nil

    // FuelType
    public dynamic var FuelType : String? = nil
    public dynamic var GatewayTime : String? = nil
    public dynamic var HarshEventState : HarshEvent? = nil
    public dynamic var VehicleHeading : Heading? = nil
    public dynamic var VehicleIdleState : IdleState? = nil
    public dynamic var IgnitionState : BooleanState? = nil
    public dynamic var VehicleLocation : Location? = nil
    public var MilStatus = RealmOptional<Bool>()
    public dynamic var MojioId : String? = nil
    public dynamic var ParkedState : BooleanState? = nil
    public dynamic var VehicleRPM : RPM? = nil
    public dynamic var VehicleSpeed : Speed? = nil
    public dynamic var TowState : BooleanState? = nil
    public dynamic var VIN : String? = nil
    public dynamic var VehicleVinDetails : VinDetails? = nil
    public dynamic var VirtualOdometer : Odometer? = nil
    public dynamic var VehicleOdometer : Odometer? = nil
    public dynamic var Time : String? = nil
    public dynamic var DisturbanceState : BooleanState? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }

    public func mapping(map: Map) {
        var diagnosticCodes = Array<DiagnosticCode>()
        diagnosticCodes <- map ["DiagnosticCodes"]
        
        for diagnosticCode in diagnosticCodes {
            self.DiagnosticCodes.append(diagnosticCode)
        }
        
        VehicleAcceleration <- map["Acceleration"]
        VehicleAccelerometer <- map["Accelerometer"]
        AccidentState <- map["AccidentState"]
        VehicleBattery <- map["Battery"]
        CurrentTrip <- map["CurrentTrip"]
        Deceleration <- map["Deceleration"]
        VehicleFuelEfficiency <- map["FuelEfficiency"]
        FuelEfficiencyCalculationMethod <- map["FuelEfficiencyCalculationMethod"]
        VehicleFuelLevel <- map["FuelLevel"]
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
