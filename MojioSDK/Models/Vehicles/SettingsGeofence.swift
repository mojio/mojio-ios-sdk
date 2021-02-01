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
import MojioCore

public protocol SettingsGeofenceModel: Codable, PrimaryKey {
    var id: String { get }
    var enableEnterActivity: Bool { get }
    var enableExitActivity: Bool { get }
}

public struct SettingsGeofence: SettingsGeofenceModel {
    
    public let id: String
    public let enableEnterActivity: Bool
    public let enableExitActivity: Bool
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case enableEnterActivity = "EnableEnterActivity"
        case enableExitActivity = "EnableExitActivity"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.id = try container.decode(String.self, forKey: .id)
            self.enableEnterActivity = try container.decode(Bool.self, forKey: .enableEnterActivity)
            self.enableExitActivity = try container.decode(Bool.self, forKey: .enableExitActivity)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}
