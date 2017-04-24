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

public struct Group: Mappable, PrimaryKey {
    public var Name: String? = nil
    public var Description: String? = nil
    public var Users: [User] = []
    public var Tags: [String] = []
    public var Id: String? = nil
    public var CreatedOn: String? = nil
    public var LastModified: String? = nil
    
    public static var primaryKey: String {
        return "Id"
    }
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }
    
    public func json () -> String? {
        var map: [String: Any] = [:]
        
        if let name = self.Name {
            map["Name"] = name
        }

        if let desc = self.Description {
            map["Description"] = desc
        }

        if self.Users.count > 0 {
            map["Users"] = self.Users
        }
        
        let data = try! JSONSerialization.data(withJSONObject: map, options:  JSONSerialization.WritingOptions.prettyPrinted)
        return NSString(data: data, encoding: String.Encoding.utf8.rawValue) as? String
    }
    
    public mutating func mapping(map: Map) {
        Users <- map["Users"]
        Tags <- map["Tags"]
        Name <- map["Name"]
        Description <- map["Description"]
        Id <- map["Id"]
        CreatedOn <- map["CreatedOn"]
        LastModified <- map["LastModified"]
    }
}
