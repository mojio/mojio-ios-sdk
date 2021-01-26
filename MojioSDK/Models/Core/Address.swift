/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2021 Copyright Moj.io Inc.
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

public protocol AddressModel: Codable {
    var houseNumber: String? { get }
    var road: String? { get }
    var neighbourhood: String? { get }
    var suburb: String? { get }
    var city: String? { get }
    var county: String? { get }
    var state: String? { get }
    var postCode: String? { get }
    var country: String? { get }
    var countryCode: String? { get }
    var formattedAddress: String? { get }
}

public struct Address: AddressModel {
    
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
    
    enum CodingKeys: String, CodingKey, CompoundWordStyle {
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
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            
            self.houseNumber = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.houseNumber)
            self.road = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.road)
            
            self.neighbourhood = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.neighbourhood)
            self.suburb = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.suburb)
            self.city = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.city)
            self.county = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.county)
            self.state = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.state)
            self.postCode = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.postCode)
            self.country = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.country)
            self.countryCode = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.countryCode)
            self.formattedAddress = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.formattedAddress)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.houseNumber, forKey: .houseNumber)
        try container.encodeIfPresent(self.road, forKey: .road)
        
        try container.encodeIfPresent(self.neighbourhood, forKey: .neighbourhood)
        try container.encodeIfPresent(self.suburb, forKey: .suburb)
        try container.encodeIfPresent(self.city, forKey: .city)
        try container.encodeIfPresent(self.county, forKey: .county)
        try container.encodeIfPresent(self.state, forKey: .state)
        try container.encodeIfPresent(self.postCode, forKey: .postCode)
        try container.encodeIfPresent(self.country, forKey: .country)
        try container.encodeIfPresent(self.countryCode, forKey: .countryCode)
        try container.encodeIfPresent(self.formattedAddress, forKey: .formattedAddress)
    }
}
