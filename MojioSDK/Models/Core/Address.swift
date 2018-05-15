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
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.houseNumber = try container.decodeIfPresent(String.self, forKey: .houseNumber)
            self.road = try container.decodeIfPresent(String.self, forKey: .road)
            
            self.neighbourhood = try container.decodeIfPresent(String.self, forKey: .neighbourhood)
            self.suburb = try container.decodeIfPresent(String.self, forKey: .suburb)
            self.city = try container.decodeIfPresent(String.self, forKey: .city)
            self.county = try container.decodeIfPresent(String.self, forKey: .county)
            self.state = try container.decodeIfPresent(String.self, forKey: .state)
            self.postCode = try container.decodeIfPresent(String.self, forKey: .postCode)
            self.country = try container.decodeIfPresent(String.self, forKey: .country)
            self.countryCode = try container.decodeIfPresent(String.self, forKey: .countryCode)
            self.formattedAddress = try container.decodeIfPresent(String.self, forKey: .formattedAddress)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
