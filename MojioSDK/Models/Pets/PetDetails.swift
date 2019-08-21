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

public enum PetType: CustomStringConvertible {
    case cat
    case dog
    case custom(String)
    
    /// Creates a new instance by using the specified string value with non case sensitive comparison.
    public init?(stringValue: String) {
        switch stringValue {
        case "Cat":
            self = .cat
        case "Dog":
            self = .dog
        default:
            self = .custom(stringValue)
            
        }
    }
    
    public var description: String {
        switch self {
        case .cat:
            return "Cat"
        case .dog:
            return "Dog"
        case .custom(let type):
            return type
        }
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
    associatedtype B: BirthdayModel
    
    var type: PetType? { get }
    var gender: Gender? { get }
    var breed: String? { get }
    var dateOfBirth: String? { get }
    var registrationId: String? { get }
    var vetName: String? { get }
    var vetPhoneNumber: String? { get }
    var lastVetVisit: Date? { get }
    var weight: Double? { get }
    var neutered: Bool? { get }
    var microchipId: String? { get }
    var microchipVendor: String? { get }
    
    var birthday: B? { get }
}

public struct PetDetails: PetDetailsModel {
    
    public typealias B = Birthday
    
    public let type: PetType?
    public let gender: Gender?
    public let breed: String?
    public let dateOfBirth: String?
    public let registrationId: String?
    public let vetName: String?
    public let vetPhoneNumber: String?
    public let lastVetVisit: Date?
    public let weight: Double?
    public let neutered: Bool?
    public let microchipId: String?
    public let microchipVendor: String?
    public let birthday: B?
    
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
        case neutered = "Neutered"
        case microchipId = "MicrochipId"
        case microchipVendor = "MicrochipVendor"
        case birthday = "Birthday"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            do {
                let petType = try container.decode(String.self, forKey: .type)
                self.type = PetType(stringValue: petType)
            }
            catch {
                self.type = PetType(stringValue: "Other")
            }
            
            self.gender = try container.decodeIfPresent(Gender.self, forKey: .gender)
            self.breed = try container.decodeIfPresent(String.self, forKey: .breed)
            self.dateOfBirth = try container.decodeIfPresent(String.self, forKey: .dateOfBirth) //.flatMap { $0.dateFromISO }
            self.registrationId = try container.decodeIfPresent(String.self, forKey: .registrationId)
            self.vetName = try container.decodeIfPresent(String.self, forKey: .vetName)
            self.vetPhoneNumber = try container.decodeIfPresent(String.self, forKey: .vetPhoneNumber)
            self.lastVetVisit = try container.decodeIfPresent(String.self, forKey: .lastVetVisit).flatMap { $0.dateFromISO }
            self.weight = try container.decodeIfPresent(Double.self, forKey: .weight)
            self.neutered = try container.decodeIfPresent(Bool.self, forKey: .neutered)
            self.microchipId = try container.decodeIfPresent(String.self, forKey: .microchipId)
            self.microchipVendor = try container.decodeIfPresent(String.self, forKey: .microchipVendor)
            self.birthday = try container.decodeIfPresent(Birthday.self, forKey: .birthday)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.type?.description, forKey: .type)
        try container.encodeIfPresent(self.gender, forKey: .gender)
        try container.encodeIfPresent(self.breed, forKey: .breed)
        try container.encodeIfPresent(self.dateOfBirth, forKey: .dateOfBirth)
        try container.encodeIfPresent(self.registrationId, forKey: .registrationId)
        try container.encodeIfPresent(self.vetName, forKey: .vetName)
        try container.encodeIfPresent(self.vetPhoneNumber, forKey: .vetPhoneNumber)
        try container.encodeIfPresent(self.lastVetVisit, forKey: .lastVetVisit)
        try container.encodeIfPresent(self.weight, forKey: .weight)
        try container.encodeIfPresent(self.neutered, forKey: .neutered)
        try container.encodeIfPresent(self.microchipId, forKey: .microchipId)
        try container.encodeIfPresent(self.microchipVendor, forKey: .microchipVendor)
        try container.encodeIfPresent(self.birthday, forKey: .birthday)
    }
}

public struct PetDetailsUpdate: Codable {
    public var type: PetType? = nil
    public var gender: Gender? = nil
    public var breed: String? = nil
    public var dateOfBirth: String? = nil
    public var registrationId: String? = nil
    public var vetName: String? = nil
    public var vetPhoneNumber: String? = nil
    public var lastVetVisit: Date? = nil
    public var weight: Double? = 0
    public var neutered: Bool? = nil
    public var microchipId: String? = nil
    public var microchipVendor: String? = nil
    public var birthday: BirthdayUpdate?
    
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
        case neutered = "Neutered"
        case microchipId = "MicrochipId"
        case microchipVendor = "MicrochipVendor"
        case birthday = "Birthday"
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
            weight: petDetails?.weight,
            neutered: petDetails?.neutered,
            microchipId: petDetails?.microchipId,
            microchipVendor: petDetails?.microchipVendor,
            birthday: BirthdayUpdate(model: petDetails?.birthday)
        )
    }
    
    public init(type: PetType? = nil,
                gender: Gender? = nil,
                breed: String? = nil,
                dateOfBirth: String? = nil,
                registrationId: String? = nil,
                vetName: String? = nil,
                vetPhoneNumber: String? = nil,
                lastVetVisit: Date? = nil,
                weight: Double? = 0,
                neutered: Bool? = nil,
                microchipId: String? = nil,
                microchipVendor: String? = nil,
                birthday: BirthdayUpdate? = nil) {
        
        self.type = type
        self.gender = gender
        self.breed = breed
        self.dateOfBirth = dateOfBirth
        self.registrationId = registrationId
        self.vetName = vetName
        self.vetPhoneNumber = vetPhoneNumber
        self.lastVetVisit = lastVetVisit
        self.weight = weight
        self.neutered = neutered
        self.microchipId = microchipId
        self.microchipVendor = microchipVendor
        self.birthday = birthday
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            do {
                let petType = try container.decode(String.self, forKey: .type)
                self.type = PetType(stringValue: petType)
            }
            catch {
                self.type = PetType(stringValue: "Other")
            }
            
            self.gender = try container.decodeIfPresent(Gender.self, forKey: .gender)
            self.breed = try container.decodeIfPresent(String.self, forKey: .breed)
            self.dateOfBirth = try container.decodeIfPresent(String.self, forKey: .dateOfBirth) //.flatMap { $0.dateFromISO }
            self.registrationId = try container.decodeIfPresent(String.self, forKey: .registrationId)
            self.vetName = try container.decodeIfPresent(String.self, forKey: .vetName)
            self.vetPhoneNumber = try container.decodeIfPresent(String.self, forKey: .vetPhoneNumber)
            self.lastVetVisit = try container.decodeIfPresent(String.self, forKey: .lastVetVisit).flatMap { $0.dateFromISO }
            self.weight = try container.decodeIfPresent(Double.self, forKey: .weight)
            self.neutered = try container.decodeIfPresent(Bool.self, forKey: .neutered)
            self.microchipId = try container.decodeIfPresent(String.self, forKey: .microchipId)
            self.microchipVendor = try container.decodeIfPresent(String.self, forKey: .microchipVendor)
            self.birthday = try container.decodeIfPresent(BirthdayUpdate.self, forKey: .birthday)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.type?.description, forKey: .type)
        try container.encodeIfPresent(self.gender, forKey: .gender)
        try container.encodeIfPresent(self.breed, forKey: .breed)
        try container.encodeIfPresent(self.dateOfBirth, forKey: .dateOfBirth)
        try container.encodeIfPresent(self.registrationId, forKey: .registrationId)
        try container.encodeIfPresent(self.vetName, forKey: .vetName)
        try container.encodeIfPresent(self.vetPhoneNumber, forKey: .vetPhoneNumber)
        try container.encodeIfPresent(self.lastVetVisit, forKey: .lastVetVisit)
        try container.encodeIfPresent(self.weight, forKey: .weight)
        try container.encodeIfPresent(self.neutered, forKey: .neutered)
        try container.encodeIfPresent(self.microchipId, forKey: .microchipId)
        try container.encodeIfPresent(self.microchipVendor, forKey: .microchipVendor)
        try container.encodeIfPresent(self.birthday, forKey: .birthday)
    }
}
