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

enum PetType: String, Codable {
    case other = "Other"
    case cat = "Cat"
    case dog = "Dog"
    
    static var all: [PetType] {
        return [.cat, .dog, .other]
    }

    /// Creates a new instance by using the specified string value with non case sensitive comparison.
    init?(stringValue: String) {
        self.init(rawValue: stringValue.capitalized)
    }
}

enum Gender: String, Codable {
    case unknown = "Unknown"
    case male = "Male"
    case female = "Female"
    case neutral = "Neutral"

    static var all: [Gender] {
        return [.unknown, .male, .female, .neutral]
    }
}

enum Weight: String, Codable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"

    
    static var all: [Weight] {
        return [.small, .medium, .large]
    }
}

struct PetDetails: Codable {
    let type: PetType?
    let gender: Gender?
    let breed: String?
    let dateOfBirth: Date?
    let registrationId: String?
    let vetName: String?
    let vetPhoneNumber: String?
    let lastVetVisit: Date?
    let weight: Int?
    
    enum CodingKeys: String, CodingKey {
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
    
    init(from decoder: Decoder) throws {
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

struct PetDetailsUpdate: Codable {
    var type: PetType? = nil
    var gender: Gender? = nil
    var breed: String? = nil
    var dateOfBirth: Date? = nil
    var registrationId: String? = nil
    var vetName: String? = nil
    var vetPhoneNumber: String? = nil
    var lastVetVisit: Date? = nil
    var weight: Int? = 0
    
    enum CodingKeys: String, CodingKey {
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
    
    init(petDetails: PetDetails? = nil) {
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
    
    init(type: PetType? = nil,
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

    func encode(to encoder: Encoder) throws {
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
