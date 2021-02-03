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

import KeychainSwift

public protocol KeychainStorageProvider {
    func get(by key: String) -> String?
    func set(value: String, for key: String)
    func delete(by key: String)
    func clear()
}

extension KeychainSwift: KeychainStorageProvider {
    public func get(by key: String) -> String? {
        return self.get(key)
    }
    
    public func set(value: String, for key: String) {
        _ = self.set(value, forKey: key)
    }
    
    public func clear() {
        let _: Bool = self.clear()
    }
    
    public func delete(by key: String) {
        _ = self.delete(key)
    }
}
