//
//  Recall.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Recall: Object, Mappable {
    
    dynamic var Title : String? = nil
    dynamic var NHTSACampaignNumber : String? = nil
    dynamic var MFRCampaignNumber : String? = nil
    dynamic var ComponentDescription : String? = nil
    dynamic var ReportManufacturer : String? = nil
    dynamic var ManufacturingStartDate : String? = nil
    dynamic var ManufacturingEndDate : String? = nil
    dynamic var RecallTypeCode : String? = nil
    dynamic var PotentialUnitsAffected : String? = nil
    dynamic var OwnerNotificationDate : String? = nil
    dynamic var RecallInitiator : String? = nil
    dynamic var ProductManufacturer : String? = nil
    dynamic var ReportReceivedDate : String? = nil
    dynamic var RecordCreationDate : String? = nil
    dynamic var RegulationPartNumber : String? = nil
    dynamic var FMVVSNumber : String? = nil
    dynamic var DefectSummary : String? = nil
    dynamic var ConsequenceSummary : String? = nil
    dynamic var CorrectiveAction : String? = nil
    dynamic var Notes : String? = nil
    dynamic var RecalledComponentId : String? = nil
    
    required convenience init?(_ map: Map) {
        self.init();
    }
    
    func mapping(map: Map) {
        
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
