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
import ObjectMapper
import KeychainSwift

public enum AccountsEndpoint: String {
    case base = "/"
    case apps = "apps/"
    case secret = "secret/"
    case groups = "groups/"
    case users = "users/"
    case me = "me/"
    case permission = "permission/"
    case permissions = "permissions/"
    case phoneNumbers = "phonenumbers/"
    case emails = "emails/"
    case tags = "tags/"
    case activities = "activities/"
    
    // Storage
    // Parameters: Type, Id, Key
    // e.g. users/{id}/store/{key}
    case storage = "%@%@/store/%@"
}

open class AccountsClient: RestClient {
    
    internal init() {
        super.init(clientEnvironment: ClientEnvironment())
    }
    
    public init(clientEnvironment: ClientEnvironment, sessionManager: SessionManager = SessionManager.default) {
        super.init(clientEnvironment: clientEnvironment, sessionManager: sessionManager)
    }
    
    open func apps(_ appId: String? = nil) -> Self {
        self.requestEntity = AccountsEndpoint.apps.rawValue
        self.requestEntityId = appId
        self.appendRequestUrlEntityId()
        
        return self
    }
    
    open func secret() -> Self {
        self.requestEntity = AccountsEndpoint.secret.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        
        return self
    }
    
    open func groups(_ groupId: String? = nil) -> Self {
        self.requestEntity = AccountsEndpoint.groups.rawValue
        self.requestEntityId = groupId
        self.appendRequestUrlEntityId()
        
        return self
    }
    
    open func users(_ userId: String? = nil) -> Self {
        self.requestEntity = AccountsEndpoint.users.rawValue
        self.requestEntityId = userId
        self.appendRequestUrlEntityId()
        self.appendPushUrlEntityId()
        
        return self
    }
    
    open func me() -> Self {
        self.requestEntity = AccountsEndpoint.me.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        
        return self
    }
    
    open func phonenumbers(_ phonenumber: String? = nil, sendVerification: Bool = false, pin: String? = nil) -> Self {
        self.requestEntity = AccountsEndpoint.phoneNumbers.rawValue
        let verificationParam = sendVerification ? "sendVerification=true" : nil
        let pinParam = pin.flatMap { "pin=\($0)" }
        let query = [verificationParam, pinParam].compactMap { $0 }.joined(separator: "&")
        self.requestEntityId = [phonenumber, (query.isEmpty ? nil : query)].compactMap { $0 }.joined(separator: "?")
        self.appendRequestUrlEntityId(asFinal: true)
        
        return self
    }
    
    open func emails (_ email: String? = nil) -> Self {
        self.requestEntity = AccountsEndpoint.emails.rawValue
        self.requestEntityId = email
        self.appendRequestUrlEntityId()
        
        return self
    }
    
    open func permission() -> Self {
        self.requestEntity = AccountsEndpoint.permission.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        
        return self
    }
    
    open func permissions() -> Self {
        self.requestEntity = AccountsEndpoint.permissions.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        
        return self
    }
    
    open func tags(_ tagId: String) -> Self {
        self.requestEntity = AccountsEndpoint.tags.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity + tagId + "/"
        
        return self
    }
    
    open func storage(_ key: String) -> Self {
        
        if let requestEntityId = self.requestEntityId {
            self.requestUrl = self.requestV1Url! + String(format: AccountsEndpoint.storage.rawValue, self.requestEntity, requestEntityId, key)
        }
        
        return self
    }
    
    open func activities() -> Self {
        self.requestEntity = AccountsEndpoint.activities.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        self.pushUrl = self.pushUrl! + self.requestEntity
        return self
    }
    
    internal override func parseData(_ responseData: Data) -> Codable? {
        do {
            switch AccountsEndpoint(rawValue: self.requestEntity) ?? .base {
                
            case .me:
                return try JSONDecoder().decode(User.self, from: responseData)
                
            case .phoneNumbers:
                do {
                    return try JSONDecoder().decode(ResponseArray<PhoneNumber>.self, from: responseData)
                }
                catch {
                    return try JSONDecoder().decode(PhoneNumber.self, from: responseData)
                }
                
            case .emails:
                do {
                    return try JSONDecoder().decode(ResponseArray<Email>.self, from: responseData)
                }
                catch {
                    return try JSONDecoder().decode(Email.self, from: responseData)
                }
                
            case .users:
                do {
                    return try JSONDecoder().decode(ResponseArray<User>.self, from: responseData)
                }
                catch {
                    return try JSONDecoder().decode(User.self, from: responseData)
                }
                
            default:
                return nil
            }
        }
        catch let error {
            debugPrint(error)
            return nil
        }
    }
    
    internal override func parseDict(_ dict: [String: Any]) -> Any? {
        switch AccountsEndpoint(rawValue: self.requestEntity) ?? .base {
            
        case .apps:
            return Mapper<App>().map(JSON: dict)
            
        case .secret:
            return nil
            
        case .groups:
            return Mapper<Group>().map(JSON: dict)
            
        case .activities:
            return Mapper<RootActivity>().map(JSON: dict)

        default:
            return super.parseDict(dict)
        }
    }
}
