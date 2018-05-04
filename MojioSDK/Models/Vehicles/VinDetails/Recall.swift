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

public struct Recall: Codable {
    
    public var title: String?
    public var nhtsaCampaignNumber: String?
    public var mfrCampaignNumber: String?
    public var componentDescription: String?
    public var reportManufacturer: String?
    public var manufacturingStartDate: Date?
    public var manufacturingEndDate: Date?
    public var recallTypeCode: String?
    public var potentialUnitsAffected: String?
    public var ownerNotificationDate: Date?
    public var recallInitiator: String?
    public var productManufacturer: String?
    public var reportReceivedDate: Date?
    public var recordCreationDate: Date?
    public var regulationPartNumber: String?
    public var fmvvsNumber: String?
    public var defectSummary: String?
    public var consequenceSummary: String?
    public var correctiveAction: String?
    public var notes: String?
    public var recalledComponentId: String?
    
    public enum CodingKeys: String, CodingKey {
        case title = "Title"
        case nhtsaCampaignNumber = "NHTSACampaignNumber"
        case mfrCampaignNumber = "MFRCampaignNumber"
        case componentDescription = "ComponentDescription"
        case reportManufacturer = "ReportManufacturer"
        case manufacturingStartDate = "ManufacturingStartDate"
        case manufacturingEndDate = "ManufacturingEndDate"
        case recallTypeCode = "RecallTypeCode"
        case potentialUnitsAffected = "PotentialUnitsAffected"
        case ownerNotificationDate = "OwnerNotificationDate"
        case recallInitiator = "RecallInitiator"
        case productManufacturer = "ProductManufacturer"
        case reportReceivedDate = "ReportReceivedDate"
        case recordCreationDate = "RecordCreationDate"
        case regulationPartNumber = "RegulationPartNumber"
        case fmvvsNumber = "FMVVSNumber"
        case defectSummary = "DefectSummary"
        case consequenceSummary = "ConsequenceSummary"
        case correctiveAction = "CorrectiveAction"
        case notes = "Notes"
        case recalledComponentId = "RecalledComponentId"
    }
}
