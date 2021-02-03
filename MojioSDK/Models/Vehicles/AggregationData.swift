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

public protocol AggregationDataModel: Codable {
    var total: Double { get }
    var average: Double { get }
    var max: Double { get }
    var min: Double { get }
    var units: String? { get }
    var date: Date? { get }
    var endDate: Date? { get }
    var count: Int { get }
    var tripCount: Int { get }
}

public struct AggregationData: AggregationDataModel {
    
    public let total        : Double
    public let average      : Double
    public let max          : Double
    public let min          : Double
    public let units        : String?
    public let date         : Date?
    public let endDate      : Date?
    public let count        : Int
    public let tripCount    : Int
    
    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
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
    
    public init(from decoder: Decoder) throws {
        
        do {
            
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            
            self.total = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.total) ?? 0
            self.average = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.average) ?? 0
            self.max = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.max) ?? 0
            self.min = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.min) ?? 0
            self.units = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.units)
            self.date = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.date).flatMap { $0.dateFromISO }
            self.endDate = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.endDate).flatMap { $0.dateFromISO }
            self.count = try container.decodeIfPresentIgnoringCase(Int.self, forKey: CodingKeys.count) ?? 0
            self.tripCount = try container.decodeIfPresentIgnoringCase(Int.self, forKey: CodingKeys.tripCount) ?? 0
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.total, forKey: .total)
        try container.encodeIfPresent(self.average, forKey: .average)
        
        try container.encodeIfPresent(self.max, forKey: .max)
        try container.encodeIfPresent(self.min, forKey: .min)
        try container.encodeIfPresent(self.units, forKey: .units)
        try container.encodeIfPresent(self.date, forKey: .date)
        try container.encodeIfPresent(self.endDate, forKey: .endDate)
        try container.encodeIfPresent(self.count, forKey: .count)
        try container.encodeIfPresent(self.tripCount, forKey: .tripCount)
    }
}
