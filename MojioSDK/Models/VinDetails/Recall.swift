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

import UIKit
import ObjectMapper

public struct Recall: Mappable {
    
    public var Title: String? = nil
    public var NHTSACampaignNumber: String? = nil
    public var MFRCampaignNumber: String? = nil
    public var ComponentDescription: String? = nil
    public var ReportManufacturer: String? = nil
    public var ManufacturingStartDate: String? = nil
    public var ManufacturingEndDate: String? = nil
    public var RecallTypeCode: String? = nil
    public var PotentialUnitsAffected: String? = nil
    public var OwnerNotificationDate: String? = nil
    public var RecallInitiator: String? = nil
    public var ProductManufacturer: String? = nil
    public var ReportReceivedDate: String? = nil
    public var RecordCreationDate: String? = nil
    public var RegulationPartNumber: String? = nil
    public var FMVVSNumber: String? = nil
    public var DefectSummary: String? = nil
    public var ConsequenceSummary: String? = nil
    public var CorrectiveAction: String? = nil
    public var Notes: String? = nil
    public var RecalledComponentId: String? = nil
    
    public var manufacturingStartDate: Date? = nil
    public var manufacturingEndDate: Date? = nil
    public var ownerNotificationDate: Date? = nil
    public var reportReceivedDate: Date? = nil
    public var recordCreationDate: Date? = nil
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }
    
    public mutating func mapping(map: Map) {
        Title <- map["Title"]
        NHTSACampaignNumber <- map["NHTSACampaignNumber"]
        MFRCampaignNumber <- map["MFRCampaignNumber"]
        ComponentDescription <- map["ComponentDescription"]
        ReportManufacturer <- map["ReportManufacturer"]
        ManufacturingStartDate <- map["ManufacturingStartDate"]
        ManufacturingEndDate <- map["ManufacturingEndDate"]
        RecallTypeCode <- map["RecallTypeCode"]
        PotentialUnitsAffected <- map["PotentialUnitsAffected"]
        OwnerNotificationDate <- map["OwnerNotificationDate"]
        RecallInitiator <- map["RecallInitiator"]
        ProductManufacturer <- map["ProductManufacturer"]
        ReportReceivedDate <- map["ReportReceivedDate"]
        RecordCreationDate <- map["RecordCreationDate"]
        RegulationPartNumber <- map["RegulationPartNumber"]
        FMVVSNumber <- map["FMVVSNumber"]
        DefectSummary <- map["DefectSummary"]
        ConsequenceSummary <- map["ConsequenceSummary"]
        CorrectiveAction <- map["CorrectiveAction"]
        Notes <- map["Notes"]
        RecalledComponentId <- map["RecalledComponentId"]
        
        manufacturingStartDate = self.ManufacturingStartDate?.toDate
        manufacturingEndDate = self.ManufacturingEndDate?.toDate
        ownerNotificationDate = self.OwnerNotificationDate?.toDate
        reportReceivedDate = self.ReportReceivedDate?.toDate
        recordCreationDate = self.RecordCreationDate?.toDate
    }
}
