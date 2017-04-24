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

public struct VehicleMeasures: Mappable {
    
    public var VehicleAcceleration: Acceleration? = nil
    public var VehicleAccelerometer: Accelerometer? = nil
    public var AccidentState: BooleanState? = nil
    public var VehicleBattery: Battery? = nil
    public var CurrentTrip: String? = nil
    public var Deceleration: Acceleration? = nil
    public var DiagnosticCodes: [DiagnosticCode] = []
    public var VehicleFuelEfficiency: FuelEfficiency? = nil
    
    // FuelEfficiencyCalculationMethod
    public var FuelEfficiencyCalculationMethod: String? = nil
    public var VehicleFuelLevel: FuelLevel? = nil
    public var VehicleFuelVolume: FuelVolume? = nil

    // FuelType
    public var FuelType: String? = nil
    public var GatewayTime: String? = nil
    public var HarshEventState: HarshEvent? = nil
    public var VehicleHeading: Heading? = nil
    public var VehicleIdleState: IdleState? = nil
    public var IgnitionState: BooleanState? = nil
    public var VehicleLocation: Location? = nil
    public var MilStatus: Bool? = nil
    public var MojioId: String? = nil
    public var ParkedState: BooleanState? = nil
    public var VehicleRPM: RPM? = nil
    public var VehicleSpeed: Speed? = nil
    public var TowState: BooleanState? = nil
    public var VIN: String? = nil
    public var VehicleVinDetails: VinDetails? = nil
    public var VirtualOdometer: Odometer? = nil
    public var VehicleOdometer: Odometer? = nil
    public var Time: String? = nil
    public var DisturbanceState: BooleanState? = nil
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }

    public mutating func mapping(map: Map) {
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
