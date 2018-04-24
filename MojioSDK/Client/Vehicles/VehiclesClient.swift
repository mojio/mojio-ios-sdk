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
import Alamofire
import SwiftyJSON
import ObjectMapper
import KeychainSwift

public enum VehiclesEndpoint: String {
    case base = "/"
    case locations = "locations/"
    case mojios = "mojios/"
    case tags = "tags/"
    case trips = "trips/"
    case vehicles = "vehicles/"
    case address = "address/"
    case vin = "vin/"
    case serviceSchedule = "serviceschedule/"
    case next = "next/"
    case activities = "activities/"
    case notificationSettings = "activities/settings/"
    case wifiRadio = "wifiradio/"
    case transactions = "transactions/"
    case geofences = "geofences/"
    case aggregates = "aggregates/"
    case statistics = "statistics/"
    case diagnosticCodes = "diagnosticcodes/"
    case polyline = "polyline/"
    
    // Storage
    // Parameters: Type, Id, Key
    // e.g. trips/{id}/store/{key}
    case storage = "%@%@/store/%@"
}

open class VehiclesClient: RestClient {

    internal init() {
        super.init(clientEnvironment: ClientEnvironment())
    }
    
    public override init(
        clientEnvironment: ClientEnvironment,
        sessionManager: SessionManager = SessionManager.default,
        keychainManager: KeychainManager? = nil) {

        super.init(clientEnvironment: clientEnvironment, sessionManager: sessionManager, keychainManager: keychainManager)
    }

    open func locations() -> Self {
        self.requestEntity = VehiclesEndpoint.locations.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        
        return self
    }
    
    open func mojios(_ mojioId: String? = nil) -> Self {
        self.requestEntity = VehiclesEndpoint.mojios.rawValue
        self.requestEntityId = mojioId
        self.appendRequestUrlEntityId()
        self.appendPushUrlEntityId()
        
        return self
    }
    
    open func tags(_ tagId: String) -> Self {
        self.requestEntity = VehiclesEndpoint.tags.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity + tagId + "/"
        
        return self
    }
    
    open func trips(_ tripId: String? = nil) -> Self {
        self.requestEntity = VehiclesEndpoint.trips.rawValue
        self.requestEntityId = tripId
        self.appendRequestUrlEntityId()
        self.appendPushUrlEntityId()
        
        return self
    }
    
    open func vehicles(_ vehicleId: String? = nil) -> Self {
        self.requestEntity = VehiclesEndpoint.vehicles.rawValue
        self.requestEntityId = vehicleId
        self.appendRequestUrlEntityId()
        self.appendPushUrlEntityId()
        
        return self
    }
    
    public func vehicles(_ vehicleId: String, mergeVehicleId: String) -> Self {
        self.requestEntity = VehiclesEndpoint.vehicles.rawValue
        self.requestEntityId = vehicleId
        self.requestParams["actual"] = mergeVehicleId as AnyObject?
        self.requestUrl = self.requestUrl! + self.requestEntity + vehicleId + "/"
        self.pushUrl = self.pushUrl! + self.requestEntity + vehicleId + "/"
        
        return self
    }
    
    open func notificationSettings() -> Self {
        self.requestEntity = VehiclesEndpoint.notificationSettings.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        return self
    }
    
    open func address() -> Self {
        self.requestEntity = VehiclesEndpoint.address.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        
        return self
    }
    
    open func vin() -> Self {
        self.requestEntity = VehiclesEndpoint.vin.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        
        return self
    }
    
    open func serviceSchedule() -> Self {
        self.requestEntity = VehiclesEndpoint.serviceSchedule.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        
        return self
    }
    
    open func next() -> Self {
        self.requestEntity = VehiclesEndpoint.next.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        
        return self
    }
    
    open func storage(_ key: String) -> Self {
        
        if let requestEntityId = self.requestEntityId {
            self.requestUrl = self.requestV1Url! + String(format: VehiclesEndpoint.storage.rawValue, self.requestEntity, requestEntityId, key)
        }
        
        return self
    }
    
    open func activities() -> Self {
        self.requestEntity = VehiclesEndpoint.activities.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        self.pushUrl = self.pushUrl! + self.requestEntity
        return self
    }
    
    open func wifiRadio() -> Self {
        self.requestEntity = VehiclesEndpoint.wifiRadio.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        
        return self
    }
    
    open func transactions(_ transactionId: String? = nil) -> Self {
        self.requestEntity = VehiclesEndpoint.transactions.rawValue
        self.requestEntityId = transactionId
        self.appendRequestUrlEntityId()
        self.appendPushUrlEntityId()
        
        return self
    }
    
    open func geofences(_ geofenceId: String? = nil) -> Self {
        self.requestEntity = VehiclesEndpoint.geofences.rawValue
        self.requestEntityId = geofenceId
        self.appendRequestUrlEntityId()
        self.appendPushUrlEntityId()
        
        return self
    }
    
    open func aggregates(ofType type: String? = nil) -> Self {
        
        self.requestEntity = VehiclesEndpoint.aggregates.rawValue
        self.appendRequestUrlEntity(self.requestEntity, asFinal: true)
        self.appendRequestUrlEntity(type)
        
        return self
    }
    
    open func statistics() -> Self {
        self.requestEntity = VehiclesEndpoint.statistics.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        
        return self
    }
    
    open func diagnosticCodes(_ code: String? = nil) -> Self {
        
        self.requestEntity = VehiclesEndpoint.diagnosticCodes.rawValue
        self.appendRequestUrlEntity(self.requestEntity, asFinal: true)
        self.appendRequestUrlEntity(code, asFinal: true)
        
        return self
    }
    
    public func polyline() -> Self {
        self.requestEntity = VehiclesEndpoint.polyline.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        
        return self
    }
    
    internal override func parseDict(_ dict: [String: Any]) -> Any? {
        switch VehiclesEndpoint(rawValue: self.requestEntity) ?? .base {
                        
        case .locations:
            return Mapper<Location>().map(JSON: dict)
            
        case .mojios:
            return Mapper<Mojio>().map(JSON: dict)
            
        case .trips:
            return Mapper<Trip>().map(JSON: dict)
            
        case .vehicles:
            return Mapper<Vehicle>().map(JSON: dict)
            
        case .address:
            return Mapper<Address>().map(JSON: dict)
            
        case .vin:
            return Mapper<Vin>().map(JSON: dict)
            
        case .serviceSchedule:
            return Mapper<ServiceSchedule>().map(JSON: dict)
            
        case .next:
            return Mapper<NextServiceSchedule>().map(JSON: dict)

        case .activities:
            return Mapper<RootActivity>().map(JSON: dict)
            
        case .notificationSettings:
            return Mapper<NotificationsSettings>().map(JSON: dict)
            
        case .wifiRadio:
            // Returns Transaction Id
            return dict["TransactionId"]
            
        case .transactions:
            // Returns Transaction State
            return dict["State"]
            
        case .geofences:
            return Mapper<Geofence>().map(JSON: dict)
            
        case .aggregates:
            return Mapper<AggregationData>().map(JSON: dict)
            
        case .statistics:
            return Mapper<VehicleStatistics>().map(JSON: dict)
            
        case .polyline:
            return Mapper<TripPolyline>().map(JSON: dict)
            
        case .diagnosticCodes:
            return Mapper<DiagnosticCode>().map(JSON: dict)
            
        default:
            return super.parseDict(dict)
        }
    }
}
