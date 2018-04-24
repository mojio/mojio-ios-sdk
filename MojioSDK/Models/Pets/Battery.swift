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

enum BatteryStatus: String, Codable {
    case unknown = "Unknown"
    case charging = "Charging"
    case lowBattery = "LowBattery"
    case normal = "Normal"
}

struct Battery: Codable {
    let level: Double?
    let status: BatteryStatus?
    
    enum CodingKeys: String, CodingKey {
        case level = "Level"
        case status = "Status"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.level = try container.decodeIfPresent(Double.self, forKey: .level)
            self.status = try container.decodeIfPresent(BatteryStatus.self, forKey: .status)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}
