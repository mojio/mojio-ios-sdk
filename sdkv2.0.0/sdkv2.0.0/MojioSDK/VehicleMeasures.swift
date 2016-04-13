//
//  VehicleMeasures.swift
//  sdkv2.0.0
//
//  Created by Ashish Agarwal on 2016-03-04.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class VehicleMeasures: Object, Mappable {
    
    dynamic var VehicleAcceleration : Acceleration? = nil
    dynamic var VehicleAccelerometer : Accelerometer? = nil
    dynamic var AccidentState : BooleanState? = nil
    dynamic var VehicleBattery : Battery? = nil
    dynamic var CurrentTrip : String? = nil
    dynamic var Deceleration : Acceleration? = nil
    var DiagnosticCodes = List<DiagnosticCode>()
    dynamic var VehicleFuelEfficiency : FuelEfficiency? = nil
    dynamic var FuelEfficiencyCalculationMethod : String? = nil// ['Query', 'EngineFuelRate', 'MassAirFlow', 'Calculated', 'None'],
    dynamic var VehicleFuelLevel : FuelLevel? = nil
    dynamic var FuelType : String? = nil // ['Query', 'Gasoline', 'Diesel', 'Electric'],
    dynamic var GatewayTime : String? = nil
    dynamic var HarshEventState : BooleanState? = nil
    dynamic var VehicleHeading : Heading? = nil
    dynamic var IdleState : BooleanState? = nil
    dynamic var IgnitionState : BooleanState? = nil
    dynamic var VehicleLocation : Location? = nil
    var MilStatus = RealmOptional<Bool>()
    dynamic var MojioId : String? = nil
    dynamic var ParkedState : BooleanState? = nil
    dynamic var VehicleRPM : RPM? = nil
    dynamic var VehicleSpeed : Speed? = nil
    dynamic var TowState : BooleanState? = nil
    dynamic var VIN : String? = nil
    dynamic var VehicleVinDetails : VinDetails? = nil
    dynamic var VirtualOdometer : Odometer? = nil
    dynamic var VehicleOdometer : Odometer? = nil
    dynamic var Time : String? = nil
    
    required convenience init?(_ map: Map) {
        self.init()
    }

    func mapping(map: Map) {
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
        IdleState <- map["IdleState"]
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
