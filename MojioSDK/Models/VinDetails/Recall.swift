//
//  Recall.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class Recall: Mappable {
    
    open dynamic var Title : String? = nil
    open dynamic var NHTSACampaignNumber : String? = nil
    open dynamic var MFRCampaignNumber : String? = nil
    open dynamic var ComponentDescription : String? = nil
    open dynamic var ReportManufacturer : String? = nil
    open dynamic var ManufacturingStartDate : String? = nil
    open dynamic var ManufacturingEndDate : String? = nil
    open dynamic var RecallTypeCode : String? = nil
    open dynamic var PotentialUnitsAffected : String? = nil
    open dynamic var OwnerNotificationDate : String? = nil
    open dynamic var RecallInitiator : String? = nil
    open dynamic var ProductManufacturer : String? = nil
    open dynamic var ReportReceivedDate : String? = nil
    open dynamic var RecordCreationDate : String? = nil
    open dynamic var RegulationPartNumber : String? = nil
    open dynamic var FMVVSNumber : String? = nil
    open dynamic var DefectSummary : String? = nil
    open dynamic var ConsequenceSummary : String? = nil
    open dynamic var CorrectiveAction : String? = nil
    open dynamic var Notes : String? = nil
    open dynamic var RecalledComponentId : String? = nil
    
    public required convenience init?(map: Map) {
        self.init();
    }
    
    public required init() {
        
    }

    open func mapping(map: Map) {
        
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
        
    }

}
