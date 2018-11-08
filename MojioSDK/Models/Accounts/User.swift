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

public protocol UserModel: Codable, PrimaryKey {
    
    associatedtype E: EmailModel
    associatedtype P: PhoneNumberModel
    
    var id: String { get }
    var firstName: String? { get }
    var lastName: String? { get }
    var userName: String? { get }
    var jurisdiction: String? { get }
    var emails: [E] { get }
    var phoneNumbers: [P] { get }
    var tags: [String] { get }
    var defaultLanguage: String? { get }
    var createdOn: Date? { get }
    var lastModified: Date? { get }
}

public struct User: UserModel {
    
    public typealias E = Email
    public typealias P = PhoneNumber
    
    public let id: String
    public let firstName: String?
    public let lastName: String?
    public let userName: String?
    public let jurisdiction: String?
    public let emails: [E]
    public let phoneNumbers: [P]
    public let tags: [String]
    public let defaultLanguage: String?
    public let createdOn: Date?
    public let lastModified: Date?
    
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
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.id = try container.decode(String.self, forKey: .id)
            self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
            self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
            self.userName = try container.decodeIfPresent(String.self, forKey: .userName)
            self.jurisdiction = try container.decodeIfPresent(String.self, forKey: .jurisdiction)
            self.emails = try container.decodeIfPresent([Email].self, forKey: .emails) ?? []
            self.phoneNumbers = try container.decodeIfPresent([PhoneNumber].self, forKey: .phoneNumbers) ?? []
            self.tags = try container.decodeIfPresent([String].self, forKey: .tags) ?? []
            self.defaultLanguage = try container.decodeIfPresent(String.self, forKey: .defaultLanguage)
            
            self.createdOn = try container.decodeIfPresent(String.self, forKey: .createdOn).flatMap { $0.dateFromISO }
            self.lastModified = try container.decodeIfPresent(String.self, forKey: .lastModified).flatMap { $0.dateFromISO }
        }
        catch let error {
            debugPrint(error)
            throw error
        }
    }
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
