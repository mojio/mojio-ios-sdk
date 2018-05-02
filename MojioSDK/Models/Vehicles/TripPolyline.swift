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

public struct Polyline: Codable, PrimaryKey {
    
    public let id: String
    public let polyline: String?
    public let createdOn: Date?
    public let lastModified: Date?
    public let deleted: Bool
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case polyline = "Polyline"
        case createdOn = "CreatedOn"
        case lastModified = "LastModified"
        case deleted = "Deleted"
    }
}
