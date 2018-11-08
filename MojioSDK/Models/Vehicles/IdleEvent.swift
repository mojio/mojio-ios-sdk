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

public protocol IdleEventState: Codable {
    
    associatedtype I: IdleStateModel
    associatedtype L: LocationModel
    
    var eventState: I? { get }
    var eventLocation: L? { get }
}

public struct IdleEvent: IdleEventState {
    
    public typealias I = IdleState
    public typealias L = Location
    
    public var eventState: I? = nil
    public var eventLocation: L? = nil
    
    public enum CodingKeys: String, CodingKey {
        case eventState = "IdleState"
        case eventLocation = "Location"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.eventState = try container.decodeIfPresent(IdleState.self, forKey: .eventState)
            self.eventLocation = try container.decodeIfPresent(Location.self, forKey: .eventLocation) 
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.eventState, forKey: .eventState)
        try container.encodeIfPresent(self.eventLocation, forKey: .eventLocation)
    }
}
