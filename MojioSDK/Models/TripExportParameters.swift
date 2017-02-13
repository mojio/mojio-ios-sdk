//
//  TripExportParameters.swift
//  Pods
//
//  Created by Oleksandr Kiporenko on 2/13/17.
//
//

import Foundation

public class TripExportFormat: NSObject {
    public static let CSV : String = "CSV"
    public static let PDF : String = "PDF"
}

public class TripExportParameters {
    public var Format: String
    public var UseMetric: Bool
    public var TimeZone: NSTimeZone? = nil
    public var StartDate: NSDate? = nil
    public var EndDate: NSDate? = nil
    public var Vehicles: [String]? = nil
    
    public init(format: String, useMetric: Bool, timeZone: NSTimeZone? = nil, startDate: NSDate? = nil, endDate: NSDate? = nil, vehicles: [String]? = nil ) {
        self.Format = format
        self.UseMetric = useMetric
        self.TimeZone = timeZone
        self.StartDate = startDate
        self.EndDate = endDate
        self.Vehicles = vehicles
    }
    
    public func jsonDict() -> NSDictionary {
        
        let startDate = "\(self.StartDate?.timeIntervalSince1970 ?? 0)"
        let endDate = "\((self.EndDate ?? NSDate()).timeIntervalSince1970)"
        
        let tz = (self.TimeZone ?? NSTimeZone.defaultTimeZone()).secondsFromGMT
        let tzSeconds = tz % 60
        let tzMinutes = (tz / 60) % 60
        let tzHours = (tz / 3600)
        
        return NSDictionary(dictionary: [
            "TimeOffset": "\(tzHours),\(tzMinutes),\(tzSeconds)",
            "StartDate": startDate,
            "EndDate": endDate,
            "Vehicles": self.Vehicles ?? "",
            "Format": self.Format,
            "Metric": self.UseMetric
            ])
    }
}
