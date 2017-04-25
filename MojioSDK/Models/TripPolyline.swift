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
import CoreLocation
import ObjectMapper

public struct TripPolyline: Mappable {
    
    public var Id: String? = nil
    public var TripPolyline: String? = nil
    public var CreatedOn: String? = nil
    public var LastModified: String? = nil
    public var Deleted: Bool = false
    
    // Date Values
    public var createdOn: Date? = nil
    public var lastModified: Date? = nil
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }
    
    public mutating func mapping(map: Map) {
        Id <- map["Id"]
        TripPolyline <- map["Polyline"]
        CreatedOn <- map["CreatedOn"]
        LastModified <- map["LastModified"]
        Deleted <- map["Deleted"]
        
        createdOn = self.CreatedOn?.toDate
        lastModified = self.LastModified?.toDate
    }
}
