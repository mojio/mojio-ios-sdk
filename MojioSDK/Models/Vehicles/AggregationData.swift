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
    
    public let total        : Double
    public let average      : Double
    public let max          : Double
    public let min          : Double
    public let units        : String?
    public let date         : Date?
    public let endDate      : Date?
    public let count        : Int
    public let tripCount    : Int
    
    public enum CodingKeys: String, CodingKey {
        case total = "Total"
        case average = "Average"
        case max = "Max"
        case min = "Min"
        case units = "Units"
        case date = "Date"
        case endDate = "EndDate"
        case count = "Count"
        case tripCount = "TripCount"
    }
}
