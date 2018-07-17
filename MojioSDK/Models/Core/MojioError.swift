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

public struct MojioError: Error {
    public var dictionary: [String:Any]
    public var message: String?
    public var code: String?
    
    public init(code: String?, message: String? = nil, dictionary: [String:Any]? = nil) {
        self.message = message
        self.code = code
        self.dictionary = dictionary ?? [:]
    }
}
