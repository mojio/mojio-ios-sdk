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

public class RootActivity: BaseActivity {
    
    public typealias T = Activity
    
    // BaseActivityLocation
    public let id: String
    public let activityType: ActivityType?
    public let href: String?
    public let name: String?
    public let nameMap: Dictionary<String, String>?
    
    // BaseActivity
    public let startTime: Date?
    public let endTime: Date?
    public let duration: TimeInterval?
    public let published: Date?
    public let updated: Date?
    
    public let context: String?
    public let content: String?
    public let location: ActivityLocation?
    public let attributedTo: Activity?
    public let summary: Dictionary<String, String>?
    public let icon: Dictionary<String, String>?

    // Root Values
    public let actor: Activity?
    public let target: Activity?
    public let result: Activity?
    public let object: Activity?
    public let origin: Activity?
    
    public enum CodingKeys: String, CodingKey {
        case actor = "Actor"
        case target = "Target"
        case result = "Result"
        case object = "Object"
        case origin = "Origin"
    }
    
    public required init(from decoder: Decoder) throws {
        
        // BaseActivityLocation
        let locationContainer = try decoder.container(keyedBy: BaseActivityLocationCodingKeys.self)
        
        do {
            self.id = try locationContainer.decode(String.self, forKey: .id)
            self.activityType = try locationContainer.decodeIfPresent(ActivityType.self, forKey: .activityType)
            self.href = try locationContainer.decodeIfPresent(String.self, forKey: .href)
            self.name = try locationContainer.decodeIfPresent(String.self, forKey: .name)
            self.nameMap = try locationContainer.decodeIfPresent(Dictionary<String, String>.self, forKey: .nameMap)
        }
        catch {
            debugPrint(error)
            throw error
        }
        
        // BaseActivity
        let activityContainer = try decoder.container(keyedBy: BaseActivityCodingKeys.self)
        
        do {
            self.startTime = try activityContainer.decodeIfPresent(String.self, forKey: .startTime).flatMap { $0.dateFromIso8601 }
            self.endTime = try activityContainer.decodeIfPresent(String.self, forKey: .endTime).flatMap { $0.dateFromIso8601 }
            self.duration = try activityContainer.decodeIfPresent(TimeInterval.self, forKey: .duration)
            self.published = try activityContainer.decodeIfPresent(String.self, forKey: .published).flatMap { $0.dateFromIso8601 }
            self.updated = try activityContainer.decodeIfPresent(String.self, forKey: .updated).flatMap { $0.dateFromIso8601 }
            self.context = try activityContainer.decodeIfPresent(String.self, forKey: .context)
            self.content = try activityContainer.decodeIfPresent(String.self, forKey: .content)
            
            self.location = try activityContainer.decodeIfPresent(ActivityLocation.self, forKey: .location)
            
            self.attributedTo = try activityContainer.decodeIfPresent(Activity.self, forKey: .attributedTo)
            
            self.summary = try activityContainer.decodeIfPresent(Dictionary<String, String>.self, forKey: .summary)
            
            self.icon = try activityContainer.decodeIfPresent(Dictionary<String, String>.self, forKey: .icon)
        }
        catch {
            debugPrint(error)
            throw error
        }
        
        // RootActivity
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.actor = try container.decodeIfPresent(Activity.self, forKey: .actor)
            self.target = try container.decodeIfPresent(Activity.self, forKey: .target)
            self.result = try container.decodeIfPresent(Activity.self, forKey: .result)
            self.object = try container.decodeIfPresent(Activity.self, forKey: .object)
            self.origin = try container.decodeIfPresent(Activity.self, forKey: .origin)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
