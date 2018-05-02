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

public struct ServiceBulletin: Codable {
    
    public var ItemNumber: String? = nil
    public var BulletinNumber: String? = nil
    public var ReplacementBulletinNumber: String? = nil
    public var DateAdded: String? = nil
    public var Component: String? = nil
    public var BulletinDate: String? = nil
    public var Summary: String? = nil
    
//    public var dateAdded: Date? = nil
//    public var bulletinDate: Date? = nil
}

extension ServiceBulletin {
    
    public var dateAdded: Date? {
        return self.DateAdded?.toDate
    }
    
    public var bulletinDate: Date? {
        return self.BulletinDate?.toDate
    }
}

//public init() {}
//
//public init?(map: Map) {
//    self.init()
//}
//
//public mutating func mapping(map: Map) {
//    ItemNumber <- map["ItemNumber"]
//    BulletinNumber <- map["BulletinNumber"]
//    ReplacementBulletinNumber <- map["ReplacementBulletinNumber"]
//    DateAdded <- map["DateAdded"]
//    Component <- map["Component"]
//    BulletinDate <- map["BulletinDate"]
//    Summary <- map["Summary"]
//
//    dateAdded = self.DateAdded?.toDate
//    bulletinDate = self.BulletinDate?.toDate
//}
