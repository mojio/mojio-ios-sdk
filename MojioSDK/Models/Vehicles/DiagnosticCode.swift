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

public protocol DiagnosticCodeModel: Codable {
    var ignored: Bool { get }
    var code: String? { get }
    var description: String? { get }
    var timestamp: Date? { get }
    var severity: String? { get }
    var instructions: String? { get }
    var stateType: String? { get }
    var diagnosticCodeType: String? { get }
}

public struct DiagnosticCode: DiagnosticCodeModel {
    
    public var ignored: Bool = false
    public var code: String? = nil
    public var description: String? = nil
    public let timestamp: Date?
    
    // RiskSeverity
    public var severity: String? = nil
    public var instructions: String? = nil
    
    // Type
    public var stateType: String? = nil
    public var diagnosticCodeType: String? = nil

    public enum CodingKeys: String, CodingKey {
        case ignored = "Ignored"
        case code = "Code"
        case description = "Description"
        case timestamp = "Timestamp"
        case severity = "Severity"
        case instructions = "Instructions"
        case stateType = "StateType"
        case diagnosticCodeType = "Type"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.ignored = try container.decodeIfPresent(Bool.self, forKey: .ignored) ?? false
            self.code = try container.decodeIfPresent(String.self, forKey: .code)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.timestamp = try container.decodeIfPresent(String.self, forKey: .timestamp).flatMap { $0.dateFromISO }
            
            self.severity = try container.decodeIfPresent(String.self, forKey: .severity)
            self.instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
            
            self.stateType = try container.decodeIfPresent(String.self, forKey: .stateType)
            self.diagnosticCodeType = try container.decodeIfPresent(String.self, forKey: .diagnosticCodeType)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.ignored, forKey: .ignored)
        try container.encodeIfPresent(self.code, forKey: .code)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.timestamp, forKey: .timestamp)
        try container.encodeIfPresent(self.severity, forKey: .severity)
        try container.encodeIfPresent(self.instructions, forKey: .instructions)
        try container.encodeIfPresent(self.stateType, forKey: .stateType)
        try container.encodeIfPresent(self.diagnosticCodeType, forKey: .diagnosticCodeType)
    }
}
