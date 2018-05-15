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
import MojioCore

public protocol GeneralHarshEvent {
    
    associatedtype H: GeneralHarshEventState
    associatedtype L: GeneralLocation
    
    var eventState: H? { get }
    var eventLocation: L? { get }
}

public struct HarshEvent: Codable, GeneralHarshEvent {
    
    public typealias H = HarshEventState
    
    public typealias L = Location
    
    
    public var eventState: H? = nil
    public var eventLocation: L? = nil
    
    public enum CodingKeys: String, CodingKey {
        case eventState = "HarshEventState"
        case eventLocation = "Location"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.eventState = try container.decodeIfPresent(HarshEventState.self, forKey: .eventState)
            self.eventLocation = try container.decodeIfPresent(Location.self, forKey: .eventLocation)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
