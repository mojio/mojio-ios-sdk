/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2019 Copyright Moj.io Inc.
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

public protocol PeopleDetailsModel: Codable {
    var gender: Gender? { get }
}

public struct PeopleDetails: PeopleDetailsModel {
    
    public let gender: Gender?
    
    public enum CodingKeys: String, CodingKey {
        case gender = "Gender"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.gender = try container.decodeIfPresent(Gender.self, forKey: .gender)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.gender, forKey: .gender)
    }
}

public struct PeopleDetailsUpdate: Codable {
    
    public var gender: Gender? = nil
    
    public enum CodingKeys: String, CodingKey {
        case gender = "Gender"
    }
    
    public init(from peopleDetailsModel: PeopleDetailsModel? = nil) {
        self.init(
            gender: peopleDetailsModel?.gender
        )
    }
    public init(gender: Gender? = nil) {
        self.gender = gender
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.gender = try container.decodeIfPresent(Gender.self, forKey: .gender)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.gender, forKey: .gender)
    }
}
