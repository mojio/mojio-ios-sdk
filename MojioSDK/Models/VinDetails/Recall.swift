//
//  Recall.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class Recall: Object, Mappable {
    
    public dynamic var Title : String? = nil
    public dynamic var NHTSACampaignNumber : String? = nil
    public dynamic var MFRCampaignNumber : String? = nil
    public dynamic var ComponentDescription : String? = nil
    public dynamic var ReportManufacturer : String? = nil
    public dynamic var ManufacturingStartDate : String? = nil
    public dynamic var ManufacturingEndDate : String? = nil
    public dynamic var RecallTypeCode : String? = nil
    public dynamic var PotentialUnitsAffected : String? = nil
    public dynamic var OwnerNotificationDate : String? = nil
    public dynamic var RecallInitiator : String? = nil
    public dynamic var ProductManufacturer : String? = nil
    public dynamic var ReportReceivedDate : String? = nil
    public dynamic var RecordCreationDate : String? = nil
    public dynamic var RegulationPartNumber : String? = nil
    public dynamic var FMVVSNumber : String? = nil
    public dynamic var DefectSummary : String? = nil
    public dynamic var ConsequenceSummary : String? = nil
    public dynamic var CorrectiveAction : String? = nil
    public dynamic var Notes : String? = nil
    public dynamic var RecalledComponentId : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init();
    }
    
    public func mapping(map: Map) {
        
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
