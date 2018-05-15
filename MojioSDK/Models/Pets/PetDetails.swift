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

public enum PetType: String, Codable {
    case other = "Other"
    case cat = "Cat"
    case dog = "Dog"
    
    public static var all: [PetType] {
        return [.cat, .dog, .other]
    }

    /// Creates a new instance by using the specified string value with non case sensitive comparison.
    public init?(stringValue: String) {
        self.init(rawValue: stringValue.capitalized)
    }
}

public enum Gender: String, Codable {
    case unknown = "Unknown"
    case male = "Male"
    case female = "Female"
    case neutral = "Neutral"

    public static var all: [Gender] {
        return [.unknown, .male, .female, .neutral]
    }
}

public enum Weight: String, Codable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"

    public static var all: [Weight] {
        return [.small, .medium, .large]
    }
}

public protocol PetDetailsModel: Codable {
    var type: PetType? { get }
    var gender: Gender? { get }
    var breed: String? { get }
    var dateOfBirth: Date? { get }
    var registrationId: String? { get }
    var vetName: String? { get }
    var vetPhoneNumber: String? { get }
    var lastVetVisit: Date? { get }
    var weight: Int? { get }
}

public struct PetDetails: PetDetailsModel {
    public let type: PetType?
    public let gender: Gender?
    public let breed: String?
    public let dateOfBirth: Date?
    public let registrationId: String?
    public let vetName: String?
    public let vetPhoneNumber: String?
    public let lastVetVisit: Date?
    public let weight: Int?
    
    public enum CodingKeys: String, CodingKey {
        case type = "Type"
        case gender = "Gender"
        case breed = "Breed"
        case dateOfBirth = "DateOfBirth"
        case registrationId = "RegistrationId"
        case vetName = "VeterinarianName"
        case vetPhoneNumber = "VeterinarianPhoneNumber"
        case lastVetVisit = "LastVeterinarianVisit"
        case weight = "Weight"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.type = try container.decodeIfPresent(PetType.self, forKey: .type)
            self.gender = try container.decodeIfPresent(Gender.self, forKey: .gender)
            self.breed = try container.decodeIfPresent(String.self, forKey: .breed)
            self.dateOfBirth = try container.decodeIfPresent(String.self, forKey: .dateOfBirth).flatMap { $0.dateFromIso8601 }
            self.registrationId = try container.decodeIfPresent(String.self, forKey: .registrationId)
            self.vetName = try container.decodeIfPresent(String.self, forKey: .vetName)
            self.vetPhoneNumber = try container.decodeIfPresent(String.self, forKey: .vetPhoneNumber)
            self.lastVetVisit = try container.decodeIfPresent(String.self, forKey: .lastVetVisit).flatMap { $0.dateFromIso8601 }
            self.weight = try container.decodeIfPresent(Int.self, forKey: .weight)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

public struct PetDetailsUpdate: Codable {
    public var type: PetType? = nil
    public var gender: Gender? = nil
    public var breed: String? = nil
    public var dateOfBirth: Date? = nil
    public var registrationId: String? = nil
    public var vetName: String? = nil
    public var vetPhoneNumber: String? = nil
    public var lastVetVisit: Date? = nil
    public var weight: Int? = 0
    
    public enum CodingKeys: String, CodingKey {
        case type = "Type"
        case gender = "Gender"
        case breed = "Breed"
        case dateOfBirth = "DateOfBirth"
        case registrationId = "RegistrationId"
        case vetName = "VeterinarianName"
        case vetPhoneNumber = "VeterinarianPhoneNumber"
        case lastVetVisit = "LastVeterinarianVisit"
        case weight = "Weight"
    }
    
    public init(petDetails: PetDetails? = nil) {
        self.init(
            type: petDetails?.type,
            gender: petDetails?.gender,
            breed: petDetails?.breed,
            dateOfBirth: petDetails?.dateOfBirth,
            registrationId: petDetails?.registrationId,
            vetName: petDetails?.vetName,
            vetPhoneNumber: petDetails?.vetPhoneNumber,
            lastVetVisit: petDetails?.lastVetVisit,
            weight: petDetails?.weight
        )
    }
    
    public init(type: PetType? = nil,
         gender: Gender? = nil,
         breed: String? = nil,
         dateOfBirth: Date? = nil,
         registrationId: String? = nil,
         vetName: String? = nil,
         vetPhoneNumber: String? = nil,
         lastVetVisit: Date? = nil,
         weight: Int? = 0) {
        
        self.type = type
        self.gender = gender
        self.breed = breed
        self.dateOfBirth = dateOfBirth
        self.registrationId = registrationId
        self.vetName = vetName
        self.vetPhoneNumber = vetPhoneNumber
        self.lastVetVisit = lastVetVisit
        self.weight = weight
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.type, forKey: .type)
        try container.encodeIfPresent(self.gender, forKey: .gender)
        try container.encodeIfPresent(self.breed, forKey: .breed)
        try container.encodeIfPresent(self.dateOfBirth, forKey: .dateOfBirth)
        try container.encodeIfPresent(self.registrationId, forKey: .registrationId)
        try container.encodeIfPresent(self.vetName, forKey: .vetName)
        try container.encodeIfPresent(self.vetPhoneNumber, forKey: .vetPhoneNumber)
        try container.encodeIfPresent(self.lastVetVisit, forKey: .lastVetVisit)
        try container.encodeIfPresent(self.weight, forKey: .weight)
    }
}
