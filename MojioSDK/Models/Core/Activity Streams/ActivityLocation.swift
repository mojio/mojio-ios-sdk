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

public struct ActivityLocation: BaseActivityLocation {
    
    // BaseActivityLocation
    public let id: String
    public let activityType: ActivityType?
    public let href: String?
    public let name: String?
    public let nameMap: Dictionary<String, String>?
    
    public let latitude: Double
    public let longitude: Double
    public let altitude: Double
    public let radius: Double
    
    private enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
        case altitude = "Altitude"
        case radius = "Radius"
    }
    
    public func toLocation() -> Location {
        
        var locationAddress: Address? = nil
        if let name = self.name {
            let address = Address.init(
                houseNumber: nil,
                road: nil,
                neighbourhood:
                nil,
                suburb: nil,
                city: nil,
                county: nil,
                state: nil,
                postCode: nil,
                country: nil,
                countryCode: nil,
                formattedAddress: name)

            locationAddress = address
        }
        
        return Location(
            locationAddress: locationAddress,
            timestamp: nil,
            lat: self.latitude,
            lng: self.longitude,
            radius: self.radius,
            status: nil,
            dilution: 0,
            altitude: 0,
            geoHash: nil)
    }
    
    public init(from decoder: Decoder) throws {
        
        // BaseActivityLocation
        let locationContainer = try decoder.container(keyedBy: BaseActivityLocationCodingKeys.self)
        
        do {
            self.id = try locationContainer.decode(String.self, forKey: .id)
            self.activityType = try locationContainer.decodeIfPresent(ActivityType.self, forKey: .activityType)
            self.href = try locationContainer.decodeIfPresent(String.self, forKey: .href)
            self.name = try locationContainer.decodeIfPresent(String.self, forKey: .name)
            self.nameMap = try locationContainer.decodeIfPresent(Dictionary<String, String>.self, forKey: .nameMap)
        }
        catch {
            debugPrint(error)
            throw error
        }
        
        // ActivityLocation
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.latitude = try container.decode(Double.self, forKey: .latitude)
            self.longitude = try container.decode(Double.self, forKey: .longitude)
            self.altitude = try container.decodeIfPresent(Double.self, forKey: .altitude) ?? 0
            self.radius = try container.decodeIfPresent(Double.self, forKey: .radius) ?? 0
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(with encoder: Encoder) throws {

    }
}
