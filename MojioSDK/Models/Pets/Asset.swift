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

enum AssetType: String, Codable {
    case pet = "Pet"
    case unknown = "Unknown"
    case other = "Other"
}

struct Asset: Codable, Equatable {
    let id: String
    let name: String?
    let deviceId: String?
    let location: PetsLocation?
    let speed: Double?
    let type: AssetType?
    let pet: PetDetails?
    let ownerId: String?
    var profileImageId: String?
    let profileImageUri: URL?
    let deleted: Bool?
    let createdOn: Date?
    let lastModified: Date?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case deviceId = "DeviceId"
        case location = "Location"
        case speed = "Speed"
        case type = "Type"
        case pet = "PetDetails"
        case ownerId = "OwnerId"
        case profileImageId = "ProfileImageId"
        case profileImageUri = "ProfileImageUri"
        case deleted = "Deleted"
        case createdOn = "CreatedOn"
        case lastModified = "LastModified"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.id = try container.decode(String.self, forKey: .id)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.deviceId = try container.decodeIfPresent(String.self, forKey: .deviceId)
            self.location = try container.decodeIfPresent(PetsLocation.self, forKey: .location)
            self.speed = try container.decodeIfPresent(Double.self, forKey: .speed)
            self.type = try container.decodeIfPresent(String.self, forKey: .type).flatMap { AssetType(rawValue: $0) }
            self.pet = try container.decodeIfPresent(PetDetails.self, forKey: .pet)
            self.ownerId = try container.decodeIfPresent(String.self, forKey: .ownerId)
            self.profileImageId = try container.decodeIfPresent(String.self, forKey: .profileImageId)
            self.profileImageUri = try container.decodeIfPresent(URL.self, forKey: .profileImageUri)
            self.deleted = try container.decodeIfPresent(Bool.self, forKey: .deleted)
            self.createdOn = try container.decodeIfPresent(String.self, forKey: .createdOn).flatMap { $0.dateFromIso8601 }
            self.lastModified = try container.decodeIfPresent(String.self, forKey: .lastModified).flatMap { $0.dateFromIso8601 }
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

func ==(lhs: Asset, rhs: Asset) -> Bool {
    return lhs.id == rhs.id
}

struct AssetUpdate: Codable {
    var name: String? = nil
    var type: AssetType? = nil
    var profileImageId: String? = nil
    var profileImageUri: URL? = nil
    var pet: PetDetailsUpdate? = nil
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case type = "Type"
        case profileImageId = "ProfileImageId"
        case profileImageUri = "ProfileImageUri"
        case pet = "PetDetails"
    }
    
    init(asset: Asset? = nil) {
        self.init(
            name: asset?.name,
            location: asset?.location,
            type: asset?.type,
            pet: PetDetailsUpdate(petDetails: asset?.pet),
            profileImageId: asset?.profileImageId,
            profileImageUri: asset?.profileImageUri
        )
    }

    init(
        name: String? = nil,
        location: PetsLocation? = nil,
        type: AssetType? = nil,
        pet: PetDetailsUpdate? = nil,
        profileImageId: String? = nil,
        profileImageUri: URL? = nil) {
        
        self.name = name
        self.type = type
        self.pet = pet
        self.profileImageId = profileImageId
        self.profileImageUri = profileImageUri
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.type, forKey: .type)
        try container.encodeIfPresent(self.profileImageId, forKey: .profileImageId)
        try container.encodeIfPresent(self.profileImageUri, forKey: .profileImageUri)
        try container.encodeIfPresent(self.pet, forKey: .pet)
    }
}
