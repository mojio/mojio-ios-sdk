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
import MojioCore

public protocol ActivityObject: PrimaryKey {
    associatedtype T: NestedActivityObject
    var id: String { get }
    var context: String? { get }
    var type: ActivityType? { get }
    var name: String? { get }
    var summary: String? { get }
    var publishedTime: Date? { get }
    var actor: T? { get }
    var audience: T? { get }
    var location: T? { get }
}

public protocol NestedActivityObject: PrimaryKey {
    var id: String { get }
    var context: String? { get }
    var type: NestedActivityType? { get }
    var name: String? { get }
    var latitude: Double? { get }
    var longitude: Double? { get }
    var altitude: Double? { get }
    var radius: Double? { get }
}

internal extension ActivityType {
    init?(from intValue: Int?) {
        guard let intValue = intValue else { return nil }
        self = intValue == 1 ? .arrive : .leave
    }
}

//TODO: to add all possible values
public enum NestedActivityType: String, Codable {
    case asset = "Asset"
    case pet = "Pet"
    case person = "Person"
    case geofence = "Geofence"
    
    public init?(from intValue: Int?) {
        guard let intValue = intValue else { return nil }
        switch intValue {
        case 1:
            self = .asset
        case 2:
            self = .pet
        case 3:
            self = .person
        case 4:
            self = .geofence
        default:
            return nil
        }
    }
}

public struct PetsActivity: Codable, ActivityObject {
    public let id: String
    public let context: String?
    public let type: ActivityType?
    public let name: String?
    public let summary: String?
    public let publishedTime: Date?
    public let actor: NestedActivity?
    public let audience: NestedActivity?
    public let location: NestedActivity?
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case context = "Context"
        case type = "Type"
        case name = "Name"
        case summary = "Summary"
        case publishedTime = "Published"
        case actor = "Actor"
        case audience = "Audience"
        case location = "Location"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.id = try container.decode(String.self, forKey: .id)
            self.context = try container.decodeIfPresent(String.self, forKey: .context)
            
            // TRIOS-58: this can come back as a numeric value in the case of notifications
            do {
                self.type = try container.decodeIfPresent(ActivityType.self, forKey: .type)
            }
            catch {
                self.type = ActivityType(from: try container.decodeIfPresent(Int.self, forKey: .type))
            }

            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.summary = try container.decodeIfPresent(String.self, forKey: .summary)
            self.publishedTime = try container.decodeIfPresent(String.self, forKey: .publishedTime)?.dateFromIso8601
            self.actor = try container.decodeIfPresent(NestedActivity.self, forKey: .actor)
            self.audience = try container.decodeIfPresent(NestedActivity.self, forKey: .audience)
            self.location = try container.decodeIfPresent(NestedActivity.self, forKey: .location)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

public func ==(lhs: PetsActivity, rhs: PetsActivity) -> Bool {
    return lhs.id == rhs.id
}

public struct NestedActivity: Codable, NestedActivityObject {
    public let id: String
    public let context: String?
    public let type: NestedActivityType?
    public let name: String?
    public let latitude: Double?
    public let longitude: Double?
    public let altitude: Double?
    public let radius: Double?

    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case context = "Context"
        case type = "Type"
        case name = "Name"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case altitude = "Altitude"
        case radius = "Radius"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.id = try container.decode(String.self, forKey: .id)
            self.context = try container.decodeIfPresent(String.self, forKey: .context)
            
            // TRIOS-58: this can come back as a numeric value in the case of notifications
            do {
                self.type = try container.decodeIfPresent(NestedActivityType.self, forKey: .type)
            }
            catch {
                self.type = NestedActivityType(from: try container.decodeIfPresent(Int.self, forKey: .type))
            }

            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
            self.longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
            self.altitude = try container.decodeIfPresent(Double.self, forKey: .altitude)
            self.radius = try container.decodeIfPresent(Double.self, forKey: .radius)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

public func ==(lhs: NestedActivity, rhs: NestedActivity) -> Bool {
    return lhs.id == rhs.id
}
