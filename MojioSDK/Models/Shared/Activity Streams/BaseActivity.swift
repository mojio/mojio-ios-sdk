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

public enum BaseActivityCodingKeys: String, CodingKey {
    case startTime = "StartTime"
    case endTime = "EndTime"
    case duration = "Duration"
    case published = "Published"
    case updated = "Updated"
    
    case context = "Context"
    case content = "Content"
    case location = "Location"
    case attributedTo = "AttributedTo"
    case summary = "SummaryMap"
    case icon = "Icon"
}

public protocol BaseActivity: BaseActivityLocation {
    
    associatedtype T: BaseActivity

    var startTime: Date? {get}
    var endTime: Date? {get}
    var duration: TimeInterval? {get}
    var published: Date? {get}
    var updated: Date? {get}
    
    var context: String? {get}
    var content: String? {get}
    var location: ActivityLocation? {get}
    var attributedTo: T? {get}
    var summary: Dictionary<String, String>? {get}
    var icon: Dictionary<String, String>? {get}
}
