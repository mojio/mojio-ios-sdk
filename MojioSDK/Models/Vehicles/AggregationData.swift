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

public enum AggregationDataMeasurementType: String {
    case measureBattery = "battery"
}

public struct AggregationData: Codable {
    
    public var Total        : Double = 0
    public var Average      : Double = 0
    public var Max          : Double = 0
    public var Min          : Double = 0
    public var Units        : String?
    public var Date         : String?
    public var EndDate      : String?
    public var Count        : Int = 0
    public var TripCount    : Int = 0
    
//    public var date: Date? = nil
//    public var endDate: Date? = nil
}

extension AggregationData {
    
    public var date: Date? {
        return self.Date?.toDate
    }
    
    public var endDate: Date? {
        return self.EndDate?.toDate
    }
}
