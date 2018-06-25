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
import KeychainSwift
import MojioCore

public enum PetsEndpoint: String {
    case base = "/"
    case activities = "activities/"
    case assets = "assets/"
    case locations = "locations/"
    case stats = "stats/"
    case devices = "devices/"
    case claim = "claim/"
    case geofences = "geofences/"
    case images = "images/"
    case imageMetadata = "metadata/"
    case notifications = "notifications/"
    case message = "message/"
}

open class PetsClient: RestClient {
    
    internal init() {
        super.init(clientEnvironment: ClientEnvironment())
    }
    
    public override init(
        clientEnvironment: ClientEnvironment,
        sessionManager: SessionManager = SessionManager.default,
        keychainManager: KeychainManager? = nil) {

        super.init(clientEnvironment: clientEnvironment, sessionManager: sessionManager, keychainManager: keychainManager)
        self.requestUrl = clientEnvironment.getTrackerEndpoint()
    }
    
    open func activities(_ assetId: String) -> Self {
        self.requestEntity = PetsEndpoint.activities.rawValue
        self.requestEntityId = assetId
        self.appendRequestUrlEntity(PetsEndpoint.activities.rawValue, asFinal: true)
        self.appendRequestUrlEntity(PetsEndpoint.assets.rawValue, asFinal: true)
        self.requestUrl = self.requestUrl! + assetId
        return self
    }
    
    open func assets(_ assetId: String? = nil) -> Self {
        self.requestEntity = PetsEndpoint.assets.rawValue
        self.requestEntityId = assetId
        self.appendRequestUrlEntityId()
        
        return self
    }

    open func asset(_ assetId: String? = nil) -> Self {
        guard let assetId = assetId else { return self }
        self.appendRequestUrlEntity("asset/\(assetId)", asFinal: true)
        
        return self
    }
   

    open func locations() -> Self {
        self.requestEntity = PetsEndpoint.locations.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        
        return self
    }
    
    open func stats(_ from: String? = nil) -> Self {
        self.requestEntity = PetsEndpoint.stats.rawValue
        self.requestEntityId = from
        self.appendRequestUrlEntityId()
        
        return self
    }
    
    open func devices(_ deviceId: String? = nil) -> Self {
        self.requestEntity = PetsEndpoint.devices.rawValue
        self.requestEntityId = deviceId
        self.appendRequestUrlEntityId()
        
        return self
    }
    
    open func claim() -> Self {
        self.requestEntity = PetsEndpoint.claim.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        
        return self
    }
    
    open func geofences(_ geofenceId: String? = nil) -> Self {
        self.requestEntity = PetsEndpoint.geofences.rawValue
        self.requestEntityId = geofenceId
        self.appendRequestUrlEntityId()
        
        return self
    }
    
    open func images(_ imageId: String? = nil) -> Self {
        self.requestEntity = PetsEndpoint.images.rawValue
        self.requestEntityId = imageId
        self.appendRequestUrlEntityId()
        
        return self
    }
    
    open func metadata() -> Self {
        self.requestEntity = PetsEndpoint.imageMetadata.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        
        return self
    }
    
    open func notifications(_ notificationId: String? = nil) -> Self {
        self.requestEntity = PetsEndpoint.notifications.rawValue
        self.requestEntityId = notificationId
        self.appendRequestUrlEntityId()
        
        return self
    }
    
    open func message() -> Self {
        self.requestEntity = PetsEndpoint.message.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        
        return self
    }
    
    open override func parseData(_ responseData: Data) -> Codable? {
        do {
            switch PetsEndpoint(rawValue: self.requestEntity) ?? .base {
            case .devices,
                 .claim:
                do {
                    return try JSONDecoder().decode(ResponseArray<Device>.self, from: responseData)
                }
                catch {
                    return try JSONDecoder().decode(Device.self, from: responseData)
                }
            case .assets:
                do {
                    return try JSONDecoder().decode(ResponseArray<Asset>.self, from: responseData)
                }
                catch {
                    return try JSONDecoder().decode(Asset.self, from: responseData)
                }
            case .geofences:
                do {
                    return try JSONDecoder().decode(ResponseArray<Geofence>.self, from: responseData)
                }
                catch {
                    return try JSONDecoder().decode(Geofence.self, from: responseData)
                }
            case .activities:
                do {
                    return try JSONDecoder().decode(ResponseArray<RootActivity>.self, from: responseData)
                }
                catch {
                    return try JSONDecoder().decode(RootActivity.self, from: responseData)
                }
            case .locations:
                do {
                    return try JSONDecoder().decode(ResponseArray<PetsLocation>.self, from: responseData)
                }
                catch {
                    return try JSONDecoder().decode(PetsLocation.self, from: responseData)
                }
            case .notifications:
                do {
                    return try JSONDecoder().decode(ResponseArray<NotificationToken>.self, from: responseData)
                }
                catch {
                    return try JSONDecoder().decode(NotificationToken.self, from: responseData)
                }
            case .stats:
                do {
                    return try JSONDecoder().decode(ResponseArray<Stats>.self, from: responseData)
                }
                catch {
                    return try JSONDecoder().decode(Stats.self, from: responseData)
                }
            default:
                return nil
            }
        }
        catch {
            return nil
        }
    }
}
