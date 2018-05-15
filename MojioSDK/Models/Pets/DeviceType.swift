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

public protocol GeneralDeviceType {
    var id: String { get }
    var make: String? { get }
    var model: String? { get }
    var tenantId: String? { get }
    var capabilities: String? { get }
    var firmwareVersion: String? { get }
}

public struct DeviceType: Codable, GeneralDeviceType {
    public let id: String
    public let make: String?
    public let model: String?
    public let tenantId: String?
    public let capabilities: String?
    public let firmwareVersion: String?
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case make = "Make"
        case model = "Model"
        case tenantId = "TenantId"
        case capabilities = "Capabilities"
        case firmwareVersion = "FirmwareVersion"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.id = try container.decode(String.self, forKey: .id)
            self.make = try container.decodeIfPresent(String.self, forKey: .make)
            self.model = try container.decodeIfPresent(String.self, forKey: .model)
            self.tenantId = try container.decodeIfPresent(String.self, forKey: .tenantId)
            self.capabilities = try container.decodeIfPresent(String.self, forKey: .capabilities)
            self.firmwareVersion = try container.decodeIfPresent(String.self, forKey: .firmwareVersion)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}
