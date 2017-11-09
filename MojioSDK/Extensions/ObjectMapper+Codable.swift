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

import ObjectMapper
import Foundation

extension Map {
    public subscript(key: CodingKey) -> Map {
        return self[key.stringValue]
    }
    
    public subscript(key: CodingKey, delimiter delimiter: String) -> Map {
        return self[key.stringValue, delimiter: delimiter]
    }
    
    public subscript(key: CodingKey, nested nested: Bool) -> Map {
        return self[key.stringValue, nested: nested]
    }
    
    public subscript(key: CodingKey, nested nested: Bool, delimiter delimiter: String) -> Map {
        return self[key.stringValue, nested: nested, delimiter: delimiter]
    }
    
    public subscript(key: CodingKey, ignoreNil ignoreNil: Bool) -> Map {
        return self[key.stringValue, ignoreNil: ignoreNil]
    }
    
    public subscript(key: CodingKey, delimiter delimiter: String, ignoreNil ignoreNil: Bool) -> Map {
        return self[key.stringValue, delimiter: delimiter, ignoreNil: ignoreNil]
    }
    
    public subscript(key: CodingKey, nested nested: Bool, ignoreNil ignoreNil: Bool) -> Map {
        return self[key.stringValue, nested: nested, ignoreNil: ignoreNil]
    }
}
