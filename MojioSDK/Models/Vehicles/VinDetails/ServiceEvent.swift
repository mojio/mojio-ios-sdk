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

public protocol GeneralServiceEvent {
    var computerCode: String? { get }
    var event: String? { get }
}

public struct ServiceEvent: Codable, GeneralServiceEvent {
    
    public let computerCode: String?
    public let event: String?
    
    public enum CodingKeys: String, CodingKey {
        case computerCode = "ComputerCode"
        case event = "Event"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.computerCode = try container.decodeIfPresent(String.self, forKey: .computerCode)
            self.event = try container.decodeIfPresent(String.self, forKey: .event)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
