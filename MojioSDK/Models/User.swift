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
import ObjectMapper

public struct User: Mappable, PrimaryKey {
    
    public var FirstName: String? = nil
    public var LastName: String? = nil
    public var UserName: String? = nil
    public var Jurisdiction: String? = nil
    public var Emails: [Email] = []
    public var PhoneNumbers: [PhoneNumber] = []
    public var Tags: [String] = []
    public var Id: String? = nil
    public var CreatedOn: String? = nil
    public var LastModified: String? = nil
    
    public var createdOn: Date? = nil
    public var lastModified: Date? = nil
    
    /* PUT & POST properties */
    public var email: String? = nil
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }

    public func jsonDict() -> [String: Any] {
        
        var map = [String: Any]()
        
        if let userName = self.UserName {
            map["UserName"] = userName
        }

        if let email = self.email {
            map["Email"] = email
        }

        if let firstName = self.FirstName {
            map["FirstName"] = firstName
        }

        if let lastName = self.LastName {
            map["LastName"] = lastName
        }
        
        return map
    }
    
    public mutating func mapping(map: Map) {
        self.FirstName <- map["FirstName"]
        self.LastName <- map["LastName"]
        self.UserName <- map["UserName"]
        self.Jurisdiction <- map["Jurisdiction"]
        self.Emails <- map["Emails"]
        self.PhoneNumbers <- map["PhoneNumbers"]
        self.Tags <- map["Tags"]
        self.Id <- map["Id"]
        self.CreatedOn <- map["CreatedOn"]
        self.LastModified <- map["LastModified"]
        
        createdOn = self.CreatedOn?.toDate
        lastModified = self.LastModified?.toDate
    }
}
