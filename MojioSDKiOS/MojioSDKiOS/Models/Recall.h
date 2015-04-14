//
//  Recall.h
//  VirtualMechanic
//
//  Created by Ashish Agarwal on 2015-03-18.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Recall : JSONModel

@property (nonatomic, strong) NSString *NHTSACampaignNumber;
@property (nonatomic, strong) NSString *MFRCampaignNumber;
@property (nonatomic, strong) NSString *ComponentDescription;
@property (nonatomic, strong) NSString *ReportManufacturer;
@property (nonatomic, strong) NSString *ManufacturingStartDate;
@property (nonatomic, strong) NSString *ManufacturingEndDate;
@property (nonatomic, strong) NSString *RecallTypeCode;
@property (nonatomic, strong) NSString *PotentialUnitsAffected;
@property (nonatomic, strong) NSString *OwnerNotificationDate;
@property (nonatomic, strong) NSString *RecallInitiator;
@property (nonatomic, strong) NSString *ProductManufacturer;
@property (nonatomic, strong) NSString *ReportRecievedDate;
@property (nonatomic, strong) NSString *RecordCreationDate;
@property (nonatomic, strong) NSString *RegulationPartNumber;
@property (nonatomic, strong) NSString *FMVVSNumber;
@property (nonatomic, strong) NSString *DefectSummary;
@property (nonatomic, strong) NSString *ConsequenceSummary;
@property (nonatomic, strong) NSString *CorrectiveAction;
@property (nonatomic, strong) NSString *Notes;
@property (nonatomic, strong) NSString *RecalledComponentId;


@end
