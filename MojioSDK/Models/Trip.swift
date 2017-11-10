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
import Foundation
import ObjectMapper

public struct Trip: Mappable, PrimaryKey {
    public var VehicleId: String? = nil
    public var Name: String? = nil
    public var Tags: [String] = []
    public var MojioId: String? = nil
    public var OwnerId: String? = nil
    public var Completed: Bool = false
    public var TripDuration: String? = nil
    public var TripDistance: Distance? = nil
    public var StartTimestamp: String? = nil
    public var EndTimestamp: String? = nil
    public var StartOdometer: Odometer? = nil
    public var EndOdometer: Odometer? = nil
    public var StartLocation: Location? = nil
    public var EndLocation: Location? = nil
    public var MaxSpeed: Speed? = nil
    public var MaxRPM: RPM? = nil
    public var MaxAcceleration: Acceleration? = nil
    public var MaxDeceleration: Acceleration? = nil
    public var Polyline: String? = nil
    public var HarshEvents: [HarshEvent] = []
    public var IdleEvents: [IdleEvent] = []
    public var TripFuelEfficiency: FuelEfficiency? = nil
    public var StartFuelLevel: FuelLevel? = nil
    public var EndFuelLevel: FuelLevel? = nil
    public var IdlingCount: Int? = nil
    public var HarshAccelCount: Int? = nil
    public var HarshDecelCount: Int? = nil
    public var Id: String? = nil
    public var CreatedOn: String? = nil
    public var LastModified: String? = nil
    
    // Date Values
    public var startTimestamp: Date? = nil
    public var endTimestamp: Date? = nil
    public var createdOn: Date? = nil
    public var lastModified: Date? = nil
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }
    
    public func json() -> String? {
        
        var map: [String: Any] = [:]
        
        if let name = self.Name {
            map["Name"] = name
        }
        
        let data = try! JSONSerialization.data(withJSONObject: map)
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    public mutating func mapping(map: Map) {
        VehicleId <- map["VehicleId"]
        Name <- map["Name"]
        MojioId <- map["MojioId"]
        OwnerId <- map["OwnerId"]
        Completed <- map["Completed"]
        TripDuration <- map["Duration"]
        TripDistance <- map["Distance"]
        StartTimestamp <- map["StartTimestamp"]
        EndTimestamp <- map["EndTimestamp"]
        StartOdometer <- map["StartOdometer"]
        EndOdometer <- map["EndOdometer"]
        StartLocation <- map["StartLocation"]
        EndLocation <- map["EndLocation"]
        MaxSpeed <- map["MaxSpeed"]
        MaxRPM <- map["MaxRPM"]
        MaxAcceleration <- map["MaxAcceleration"]
        MaxDeceleration <- map["MaxDeceleration"]
        Polyline <- map["Polyline"]
        HarshEvents <- map["HarshEvents"]
        IdleEvents <- map["IdleEvents"]
        TripFuelEfficiency <- map["FuelEfficiency"]
        StartFuelLevel <- map["StartFuelLevel"]
        EndFuelLevel <- map["EndFuelLevel"]
        IdlingCount <- map["IdlingCount"]
        HarshAccelCount <- map["HarshAcclCount"]
        HarshDecelCount <- map["HarshDecelCount"]
        Id <- map["Id"]
        CreatedOn <- map["CreatedOn"]
        LastModified <- map["LastModified"]
        Tags <- map["Tags"]
        
        // Date Values
        startTimestamp = self.StartTimestamp?.toDate
        endTimestamp = self.EndTimestamp?.toDate
        createdOn = self.CreatedOn?.toDate
        lastModified = self.LastModified?.toDate
    }
}
