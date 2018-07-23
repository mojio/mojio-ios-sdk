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

import Foundation
import Alamofire
import SwiftyJSON
import KeychainSwift
import MojioCore

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
    case settings = "settings/"
    case timeline = "timeline/assets/"

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
        self.requestParams["actual"] = mergeVehicleId
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
    
    open func timeline(_ vehicleId: String) -> Self {
        
        self.requestEntity = VehiclesEndpoint.timeline.rawValue
        self.requestUrl = self.requestV3Url! + self.requestEntity + vehicleId + "/"
        
        return self
    }

    public func polyline() -> Self {
        self.requestEntity = VehiclesEndpoint.polyline.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        
        return self
    }
    
    public func settings() -> Self {
        self.requestEntity = VehiclesEndpoint.settings.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        
        return self
    }
    
    open override func parseData(_ responseData: Data) -> Codable? {
        
        do {
            
            switch VehiclesEndpoint(rawValue: self.requestEntity) ?? .base {
            
            case .locations:
                do {
                    return try JSONDecoder().decode(ResponseArray<Location>.self, from: responseData)
                }
                catch {
                    return try JSONDecoder().decode(Location.self, from: responseData)
                }
            
            case .mojios:
                do {
                    return try JSONDecoder().decode(ResponseArray<Mojio>.self, from: responseData)
                }
                catch {
                    return try JSONDecoder().decode(Mojio.self, from: responseData)
                }
            
            case .trips:
                do {
                    return try JSONDecoder().decode(ResponseArray<Trip>.self, from: responseData)
                }
                catch {
                    return try JSONDecoder().decode(Trip.self, from: responseData)
                }
            
            case .vehicles:
                do {
                    return try JSONDecoder().decode(ResponseArray<Vehicle>.self, from: responseData)
                }
                catch {
                    return try JSONDecoder().decode(Vehicle.self, from: responseData)
                }
            
            case .address:
                return try JSONDecoder().decode(Address.self, from: responseData)
            
            case .vin:
                return try JSONDecoder().decode(Vin.self, from: responseData)
            
            case .serviceSchedule:
                return try JSONDecoder().decode(ServiceSchedule.self, from: responseData)
            
            case .next:
                return try JSONDecoder().decode(NextServiceSchedule.self, from: responseData)
            
            case .notificationSettings:
                return try JSONDecoder().decode(NotificationsSettings.self, from: responseData)
            
            case .geofences:
                do {
                    return try JSONDecoder().decode(ResponseArray<Geofence>.self, from: responseData)
                }
                catch {
                    return try JSONDecoder().decode(Geofence.self, from: responseData)
                }
            
            case .aggregates:
                do {
                    return try JSONDecoder().decode(ResponseArray<AggregationData>.self, from: responseData)
                }
                catch {
                    return try JSONDecoder().decode(AggregationData.self, from: responseData)
                }
            
            case .statistics:
                return try JSONDecoder().decode(VehicleStatistics.self, from: responseData)
            
            case .polyline:
                return try JSONDecoder().decode(Polyline.self, from: responseData)
            
            case .diagnosticCodes:
                do {
                    return try JSONDecoder().decode(ResponseArray<DiagnosticCode>.self, from: responseData)
                }
                catch {
                    return try JSONDecoder().decode(DiagnosticCode.self, from: responseData)
                }

            case .activities:  // conformance to be implemented
                do {
                    return try JSONDecoder().decode(ResponseArray<RootActivity>.self, from: responseData)
                }
                catch {
                    return try JSONDecoder().decode(RootActivity.self, from: responseData)
                }
                
            case .timeline:  // conformance to be implemented
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(VehiclesClient.iso8601)
                do {
                    return try decoder.decode(ResponseArray<Timeline.RootActivity>.self, from: responseData)
                }
                catch {
                    return try decoder.decode(Timeline.RootActivity.self, from: responseData)
                }

            case .wifiRadio:
                // Returns Transaction Id
                let response = try JSONDecoder().decode([String: String].self, from: responseData)
                return response["TransactionId"]

            case .transactions:
                // Returns Transaction State
                let response = try JSONDecoder().decode([String: String].self, from: responseData)
                return response["State"]
                
            case .settings:
                do {
                    return try JSONDecoder().decode(ResponseArray<VehicleActivitySettings>.self, from: responseData)
                }
                catch {
                    return try JSONDecoder().decode(VehicleActivitySettings.self, from: responseData)
                }
            
            default:
                return nil
            }
        }
        catch let error {
            debugPrint(error)
            return nil
        }
    }
    
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}
