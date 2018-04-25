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

//import UIKit
import Foundation

public struct BooleanState: Codable {
    
    public var Timestamp: String? = nil
    public var Value: Bool = false
    
    //public var timeStamp: Date? = nil
}

extension BooleanState {
    
    public var timeStamp: Date? {
        return self.Timestamp?.toDate
    }
}

//public init() {}
