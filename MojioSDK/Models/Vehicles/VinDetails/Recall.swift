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

public protocol RecallModel: Codable {
    var title: String? { get }
    var nhtsaCampaignNumber: String? { get }
    var mfrCampaignNumber: String? { get }
    var componentDescription: String? { get }
    var reportManufacturer: String? { get }
    var manufacturingStartDate: Date? { get }
    var manufacturingEndDate: Date? { get }
    var recallTypeCode: String? { get }
    var potentialUnitsAffected: String? { get }
    var ownerNotificationDate: Date? { get }
    var recallInitiator: String? { get }
    var productManufacturer: String? { get }
    var reportReceivedDate: Date? { get }
    var recordCreationDate: Date? { get }
    var regulationPartNumber: String? { get }
    var fmvvsNumber: String? { get }
    var defectSummary: String? { get }
    var consequenceSummary: String? { get }
    var correctiveAction: String? { get }
    var notes: String? { get }
    var recalledComponentId: String? { get }
}

public struct Recall: RecallModel {
    
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
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.title = try container.decodeIfPresent(String.self, forKey: .title)
            self.nhtsaCampaignNumber = try container.decodeIfPresent(String.self, forKey: .nhtsaCampaignNumber)
            self.mfrCampaignNumber = try container.decodeIfPresent(String.self, forKey: .mfrCampaignNumber)
            self.componentDescription = try container.decodeIfPresent(String.self, forKey: .componentDescription)
            self.reportManufacturer = try container.decodeIfPresent(String.self, forKey: .reportManufacturer)
            self.manufacturingStartDate = try container.decodeIfPresent(String.self, forKey: .manufacturingStartDate).flatMap { $0.dateFromISO }
            self.manufacturingEndDate = try container.decodeIfPresent(String.self, forKey: .manufacturingEndDate).flatMap { $0.dateFromISO }
            self.recallTypeCode = try container.decodeIfPresent(String.self, forKey: .recallTypeCode)
            
            self.potentialUnitsAffected = try container.decodeIfPresent(String.self, forKey: .potentialUnitsAffected)
            self.ownerNotificationDate = try container.decodeIfPresent(String.self, forKey: .ownerNotificationDate).flatMap { $0.dateFromISO }
            self.recallInitiator = try container.decodeIfPresent(String.self, forKey: .recallInitiator)
            
            self.componentDescription = try container.decodeIfPresent(String.self, forKey: .componentDescription)
            self.reportManufacturer = try container.decodeIfPresent(String.self, forKey: .reportManufacturer)
            self.productManufacturer = try container.decodeIfPresent(String.self, forKey: .productManufacturer)
            self.reportReceivedDate = try container.decodeIfPresent(String.self, forKey: .reportReceivedDate).flatMap { $0.dateFromISO }
            self.recordCreationDate = try container.decodeIfPresent(String.self, forKey: .recordCreationDate).flatMap { $0.dateFromISO }
            
            self.regulationPartNumber = try container.decodeIfPresent(String.self, forKey: .regulationPartNumber)
            self.fmvvsNumber = try container.decodeIfPresent(String.self, forKey: .fmvvsNumber)
            self.defectSummary = try container.decodeIfPresent(String.self, forKey: .defectSummary)
            self.consequenceSummary = try container.decodeIfPresent(String.self, forKey: .consequenceSummary)
            self.correctiveAction = try container.decodeIfPresent(String.self, forKey: .correctiveAction)
            
            self.notes = try container.decodeIfPresent(String.self, forKey: .notes)
            self.recalledComponentId = try container.decodeIfPresent(String.self, forKey: .recalledComponentId)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.nhtsaCampaignNumber, forKey: .nhtsaCampaignNumber)
        try container.encodeIfPresent(self.mfrCampaignNumber, forKey: .mfrCampaignNumber)
        try container.encodeIfPresent(self.componentDescription, forKey: .componentDescription)
        try container.encodeIfPresent(self.reportManufacturer, forKey: .reportManufacturer)
        try container.encodeIfPresent(self.manufacturingStartDate, forKey: .manufacturingStartDate)
        try container.encodeIfPresent(self.manufacturingEndDate, forKey: .manufacturingEndDate)
        try container.encodeIfPresent(self.recallTypeCode, forKey: .recallTypeCode)
        
        try container.encodeIfPresent(self.potentialUnitsAffected, forKey: .potentialUnitsAffected)
        try container.encodeIfPresent(self.ownerNotificationDate, forKey: .ownerNotificationDate)
        try container.encodeIfPresent(self.recallInitiator, forKey: .recallInitiator)
        
        try container.encodeIfPresent(self.componentDescription, forKey: .componentDescription)
        try container.encodeIfPresent(self.reportManufacturer, forKey: .reportManufacturer)
        try container.encodeIfPresent(self.productManufacturer, forKey: .productManufacturer)
        try container.encodeIfPresent(self.reportReceivedDate, forKey: .reportReceivedDate)
        try container.encodeIfPresent(self.recordCreationDate, forKey: .recordCreationDate)
        
        try container.encodeIfPresent(self.regulationPartNumber, forKey: .regulationPartNumber)
        try container.encodeIfPresent(self.fmvvsNumber, forKey: .fmvvsNumber)
        try container.encodeIfPresent(self.defectSummary, forKey: .defectSummary)
        try container.encodeIfPresent(self.consequenceSummary, forKey: .consequenceSummary)
        try container.encodeIfPresent(self.correctiveAction, forKey: .correctiveAction)
        
        try container.encodeIfPresent(self.notes, forKey: .notes)
        try container.encodeIfPresent(self.recalledComponentId, forKey: .recalledComponentId)
    }
}
