/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2019 Copyright Moj.io Inc.
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

public protocol PeopleDetailsModel: Codable {
    
    associatedtype B: BirthdayModel
    
    var birthday: B? { get }
    var gender: Gender? { get }
    var dateOfBirth: String? { get }
    var eyeColor: String? { get }
    var hairColor: String? { get }
    var height: Double? { get }
    var weight: Double? { get }
}

public struct PeopleDetails: PeopleDetailsModel {
    
    public typealias B = Birthday
    
    public let birthday: B?
    public let gender: Gender?
    public let dateOfBirth: String?
    public let eyeColor: String?
    public let hairColor: String?
    public let height: Double?
    public let weight: Double?
    
    public enum CodingKeys: String, CodingKey {
        
        case birthday = "Birthday"
        case gender = "Gender"
        case dateOfBirth = "DateOfBirth"
        case eyeColor = "EyeColor"
        case hairColor = "HairColor"
        case height = "Height"
        case weight = "Weight"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.birthday = try container.decodeIfPresent(Birthday.self, forKey: .birthday)
            self.gender = try container.decodeIfPresent(Gender.self, forKey: .gender)
            self.dateOfBirth = try container.decodeIfPresent(String.self, forKey: .dateOfBirth) //.flatMap { $0.dateFromISO }
            self.eyeColor = try container.decodeIfPresent(String.self, forKey: .eyeColor)
            self.hairColor = try container.decodeIfPresent(String.self, forKey: .hairColor)
            self.height = try container.decodeIfPresent(Double.self, forKey: .height)
            self.weight = try container.decodeIfPresent(Double.self, forKey: .weight)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.birthday, forKey: .birthday)
        try container.encodeIfPresent(self.gender, forKey: .gender)
        try container.encodeIfPresent(self.dateOfBirth, forKey: .dateOfBirth)
        try container.encodeIfPresent(self.eyeColor, forKey: .eyeColor)
        try container.encodeIfPresent(self.hairColor, forKey: .hairColor)
        try container.encodeIfPresent(self.height, forKey: .height)
        try container.encodeIfPresent(self.weight, forKey: .weight)
    }
}

public struct PeopleDetailsUpdate: Codable {
    
    public var birthday: BirthdayUpdate?
    public var gender: Gender? = nil
    public var dateOfBirth: String? = nil
    public var eyeColor: String? = nil
    public var hairColor: String? = nil
    public var height: Double? = nil
    public var weight: Double? = nil
    
    public enum CodingKeys: String, CodingKey {
        
        case birthday = "Birthday"
        case gender = "Gender"
        case dateOfBirth = "DateOfBirth"
        case eyeColor = "EyeColor"
        case hairColor = "HairColor"
        case height = "Height"
        case weight = "Weight"
    }
    
    public init(peopleDetailsModel: PeopleDetails? = nil) {
        self.init(
            birthday: BirthdayUpdate(model: peopleDetailsModel?.birthday),
            gender: peopleDetailsModel?.gender,
            dateOfBirth: peopleDetailsModel?.dateOfBirth,
            eyeColor: peopleDetailsModel?.eyeColor,
            hairColor: peopleDetailsModel?.hairColor,
            height: peopleDetailsModel?.height,
            weight: peopleDetailsModel?.weight
        )
    }
    public init(birthday: BirthdayUpdate? = nil,
                gender: Gender? = nil,
                dateOfBirth: String? = nil,
                eyeColor: String? = nil,
                hairColor: String? = nil,
                height: Double? = nil,
                weight: Double? = nil) {
        self.birthday = birthday
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.eyeColor = eyeColor
        self.hairColor = hairColor
        self.height = height
        self.weight = weight
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.birthday = try container.decodeIfPresent(BirthdayUpdate.self, forKey: .birthday)
            self.gender = try container.decodeIfPresent(Gender.self, forKey: .gender)
            self.dateOfBirth = try container.decodeIfPresent(String.self, forKey: .dateOfBirth) //.flatMap { $0.dateFromISO }
            self.eyeColor = try container.decodeIfPresent(String.self, forKey: .eyeColor)
            self.hairColor = try container.decodeIfPresent(String.self, forKey: .hairColor)
            self.height = try container.decodeIfPresent(Double.self, forKey: .height)
            self.weight = try container.decodeIfPresent(Double.self, forKey: .weight)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.birthday, forKey: .birthday)
        try container.encodeIfPresent(self.gender, forKey: .gender)
        try container.encodeIfPresent(self.dateOfBirth, forKey: .dateOfBirth)
        try container.encodeIfPresent(self.eyeColor, forKey: .eyeColor)
        try container.encodeIfPresent(self.hairColor, forKey: .hairColor)
        try container.encodeIfPresent(self.height, forKey: .height)
        try container.encodeIfPresent(self.weight, forKey: .weight)
    }
}
