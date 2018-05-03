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

public struct Address: Codable {
    
    public let houseNumber: String?
    public let road: String?
    public let neighbourhood: String?
    public let suburb: String?
    public let city: String?
    public let county: String?
    public let state: String?
    public let postCode: String?
    public let country: String?
    public let countryCode: String?
    public let formattedAddress: String?
    
    enum CodingKeys: String, CodingKey {
        case houseNumber = "HouseNumber"
        case road = "Road"
        case neighbourhood = "Neighbourhood"
        case suburb = "Suburb"
        case city = "City"
        case county = "County"
        case state = "State"
        case postCode = "PostCode"
        case country = "Country"
        case countryCode = "CountryCode"
        case formattedAddress = "FormattedAddress"
    }
}
