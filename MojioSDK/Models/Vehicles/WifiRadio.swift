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

public enum TransactionState: String {
    case pending = "Pending"
    case success = "Success"
    case failure = "Failure"
}

public protocol WifiRadioModel: Codable {
    var timestamp: Date? { get }
    var ssid: String? { get }
    var password: String? { get }
    var allowRoaming: Bool? { get }
    var status: WifiRadioStatus? { get }
    var strength: Double? { get }
}

public protocol WifiRadioUpdateModel: Codable {
    var ssid: String? { get }
    var password: String? { get }
    var status: String? { get }
}

public enum WifiRadioStatus: String, Codable {
    
    case connected = "Connected"
    case roaming = "Roaming"
    case disconnected = "Disconnected"
    
    case unknown
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = WifiRadioStatus(rawValue: label) ?? .unknown
    }
}

public struct WifiRadio: WifiRadioModel {
    
    public enum CodingKeys: String, CodingKey {
        case timestamp = "Timestamp"
        case ssid = "SSID"
        case password = "Password"
        case allowRoaming = "AllowRoaming"
        case status = "Status"
        case strength = "Strength"
    }
    
    public let timestamp: Date?
    public let ssid: String?
    public let password: String?
    public let allowRoaming: Bool?
    public let status: WifiRadioStatus?
    public let strength: Double?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.timestamp = try container.decodeIfPresent(String.self, forKey: .timestamp).flatMap { $0.dateFromIso8601 }
            self.ssid = try container.decodeIfPresent(String.self, forKey: .ssid)
            self.password = try container.decodeIfPresent(String.self, forKey: .password)
            self.allowRoaming = try container.decodeIfPresent(Bool.self, forKey: .allowRoaming)
            self.status = try container.decodeIfPresent(WifiRadioStatus.self, forKey: .status)
            self.strength = try container.decodeIfPresent(Double.self, forKey: .strength)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

// TODO: Update to handle TTL, etc. - see below
public struct WifiRadioUpdate: WifiRadioUpdateModel {
    public var ssid: String? = nil
    public var password: String? = nil
    public var status: String? = nil
    
    public enum CodingKeys: String, CodingKey {
        case ssid = "SSID"
        case password = "Password"
        case status = "Status"
    }
}

// Time to live in seconds for the update request
//    public func jsonDict(_ timeToLive: Int? = nil, fields: [String]? = nil) -> [String: Any] {
//        var map: [String: Any] = [:]
//
//        // Default to use all fields
//        var updateFields: Set<String> = ["SSID", "Password", "Status"]
//        if let fields = fields {
//            updateFields = Set<String>(fields)
//        }
//
//        if let ssid = self.SSID , updateFields.contains("SSID") {
//            map["SSID"] = ssid
//        }
//
//        if let password = self.Password , updateFields.contains("Password") {
//            map["Password"] = password
//        }
//
//        if let status = self.Status, updateFields.contains("Status") {
//            map["Status"] = status
//        }
//
//        if let timeToLive: Int = timeToLive , timeToLive > 0 {
//            let formatter = NumberFormatter()
//            formatter.minimumIntegerDigits = 2
//            formatter.maximumIntegerDigits = 2
//            formatter.minimumFractionDigits = 0
//            formatter.maximumFractionDigits = 0
//
//            var timespan = ""
//
//            let seconds = formatter.string(from: NSNumber(value: timeToLive % 60 as Int)) ?? ""
//            if timeToLive < 60 {
//                // Less than 60 seconds
//                timespan = String(format:"00:00:%@", seconds)
//            }
//            else {
//                let minutes = formatter.string(from: NSNumber(value: (timeToLive % 3600) / 60 as Int)) ?? ""
//                if timeToLive < 3600 {
//                    // Less than 1 hour
//                    timespan = String(
//                        format:"00:%@:%@",
//                        minutes,
//                        seconds)
//                }
//                else {
//                    let hours = formatter.string(from: NSNumber(value: timeToLive / 3600 as Int)) ?? ""
//                    timespan = String(format:"%@:%@:%@", hours, minutes, seconds)
//                }
//            }
//
//            if timespan.count > 0 {
//                map["TimeToLive"] = timespan
//            }
//        }
//
//        return map
//    }
