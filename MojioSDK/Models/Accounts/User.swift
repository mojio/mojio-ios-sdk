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
import ObjectMapper

public struct User: Codable, Equatable, Mappable {
    
    private(set) var id: String = String.empty
    private(set) var firstName: String? = nil
    private(set) var lastName: String? = nil
    private(set) var userName: String? = nil
    private(set) var jurisdiction: String? = nil
    private(set) var emails: [Email]? = nil
    private(set) var phoneNumbers: [PhoneNumber]? = nil
    private(set) var tags: [String]? = nil
    private(set) var defaultLanguage: String? = nil
    private(set) var createdOn: Date? = nil
    private(set) var lastModified: Date? = nil
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case firstName = "FirstName"
        case lastName = "LastName"
        case userName = "UserName"
        case jurisdiction = "Jurisdiction"
        case emails = "Emails"
        case phoneNumbers = "PhoneNumbers"
        case tags = "Tags"
        case defaultLanguage = "DefaultLanguage"
        case createdOn = "CreatedOn"
        case lastModified = "LastModified"
    }
    
    public init?(map: Map) {}
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.id = try container.decode(String.self, forKey: .id)
            self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
            self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
            self.userName = try container.decodeIfPresent(String.self, forKey: .userName)
            self.jurisdiction = try container.decodeIfPresent(String.self, forKey: .jurisdiction)
            self.emails = try container.decodeIfPresent([Email].self, forKey: .emails)
            self.phoneNumbers = try container.decodeIfPresent([PhoneNumber].self, forKey: .phoneNumbers)
            self.tags = try container.decodeIfPresent([String].self, forKey: .tags)
            self.defaultLanguage = try container.decodeIfPresent(String.self, forKey: .defaultLanguage)
            
            self.createdOn = try container.decodeIfPresent(String.self, forKey: .createdOn).flatMap { $0.dateFromIso8601 }
            self.lastModified = try container.decodeIfPresent(String.self, forKey: .lastModified).flatMap { $0.dateFromIso8601 }
        }
        catch let error {
            debugPrint(error)
            throw error
        }
    }
    
    public mutating func mapping(map: Map) {
        self.firstName <- map[CodingKeys.firstName.rawValue]
        self.lastName <- map[CodingKeys.lastName.rawValue]
        self.userName <- map[CodingKeys.userName.rawValue]
        self.jurisdiction <- map[CodingKeys.jurisdiction.rawValue]
        self.emails <- map[CodingKeys.emails.rawValue]
        self.phoneNumbers <- map[CodingKeys.phoneNumbers.rawValue]
        self.tags <- map[CodingKeys.tags.rawValue]
        self.id <- map[CodingKeys.tags.rawValue]
        let createdOn = map[CodingKeys.createdOn.rawValue].currentValue as? String
        let lastModified = map[CodingKeys.lastModified.rawValue].currentValue as? String
        
        self.createdOn = createdOn?.toDate
        self.lastModified = lastModified?.toDate
    }
}

public func ==(lhs: User, rhs: User) -> Bool {
    return lhs.id == rhs.id
}

public struct UserUpdate: Codable {
    public var userName: String? = nil
    public var email: String? = nil
    public var firstName: String? = nil
    public var lastName: String? = nil
    
    public enum CodingKeys: String, CodingKey {
        case userName = "UserName"
        case email = "Email"
        case firstName = "FirstName"
        case lastName = "LastName"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.userName, forKey: .userName)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.firstName, forKey: .firstName)
        try container.encodeIfPresent(self.lastName, forKey: .lastName)
    }
}
