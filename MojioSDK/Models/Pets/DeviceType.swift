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

struct DeviceType: Codable {
    let id: String?
    let make: String?
    let model: String?
    let tenantId: String?
    let capabilities: String?
    let firmwareVersion: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case make = "Make"
        case model = "Model"
        case tenantId = "TenantId"
        case capabilities = "Capabilities"
        case firmwareVersion = "FirmwareVersion"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.id = try container.decodeIfPresent(String.self, forKey: .id)
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
