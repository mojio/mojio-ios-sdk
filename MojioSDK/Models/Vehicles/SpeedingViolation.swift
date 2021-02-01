/******************************************************************************
* Moj.io Inc. CONFIDENTIAL
* 2021 Copyright Moj.io Inc.
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
import MojioCore

public protocol SpeedingViolationModel: Codable {

    associatedtype L: LocationModel
    associatedtype S: SpeedModel
    
    var startTimestamp: Date? { get }
    var endTimestamp: Date? { get }
    var startLocation: L? { get }
    var endLocation: L? { get }
    var maxSpeed: S? { get }
    var minSpeed: S? { get }
    var averageSpeed: S? { get }
    var speedingScore: Double? { get }
    var polyline: String? { get }
    var averageSpeedDelta: S? { get }
}

public struct SpeedingViolation: SpeedingViolationModel {

    public typealias L = Location
    public typealias S = Speed
    
    public let startTimestamp: Date?
    public let endTimestamp: Date?
    public let startLocation: L?
    public let endLocation: L?
    public let maxSpeed: S?
    public let minSpeed: S?
    public let averageSpeed: S?
    public let speedingScore: Double?
    public let polyline: String?
    public var averageSpeedDelta: S?
    
    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case startTimestamp = "StartTimestamp"
        case endTimestamp = "EndTimestamp"
        case startLocation = "StartLocation"
        case endLocation = "EndLocation"
        case maxSpeed = "MaxSpeed"
        case minSpeed = "MinSpeed"
        case averageSpeed = "AverageSpeed"
        case speedingScore = "SpeedingScore"
        case polyline = "Polyline"
        case averageSpeedDelta = "AverageSpeedDelta"
    }

    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)

            self.startTimestamp = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.startTimestamp).flatMap { $0.dateFromISO }
            self.endTimestamp = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.endTimestamp).flatMap { $0.dateFromISO }

            self.startLocation = try container.decodeIfPresentIgnoringCase(L.self, forKey: CodingKeys.startLocation)
            self.endLocation = try container.decodeIfPresentIgnoringCase(L.self, forKey: CodingKeys.endLocation)

            self.maxSpeed = try container.decodeIfPresentIgnoringCase(S.self, forKey: CodingKeys.maxSpeed)
            self.minSpeed = try container.decodeIfPresentIgnoringCase(S.self, forKey: CodingKeys.minSpeed)
            self.averageSpeed = try container.decodeIfPresentIgnoringCase(Speed.self, forKey: CodingKeys.averageSpeed)

            self.polyline = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.polyline)

            self.speedingScore = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.speedingScore)

            self.averageSpeedDelta = try container.decodeIfPresentIgnoringCase(Speed.self, forKey: CodingKeys.averageSpeedDelta)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(self.startTimestamp, forKey: .startTimestamp)
        try container.encodeIfPresent(self.endTimestamp, forKey: .endTimestamp)

        try container.encodeIfPresent(self.startLocation, forKey: .startLocation)
        try container.encodeIfPresent(self.endLocation, forKey: .endLocation)

        try container.encodeIfPresent(self.maxSpeed, forKey: .maxSpeed)
        try container.encodeIfPresent(self.minSpeed, forKey: .minSpeed)
        try container.encodeIfPresent(self.averageSpeed, forKey: .averageSpeed)

        try container.encodeIfPresent(self.polyline, forKey: .polyline)

        try container.encodeIfPresent(self.speedingScore, forKey: .speedingScore)

        try container.encodeIfPresent(self.averageSpeedDelta, forKey: .averageSpeedDelta)
    }
}
