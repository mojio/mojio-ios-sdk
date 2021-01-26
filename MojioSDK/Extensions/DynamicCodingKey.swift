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

struct MultipleError: Error {
    let errors: [Error]
}

class DynamicCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    
    required init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    required init?(intValue: Int) {
        return nil
    }
    
    static func makeKey(_ stringValue: String) -> DynamicCodingKey {
        return DynamicCodingKey(stringValue: stringValue)!
    }
}

extension KeyedDecodingContainer where Key == DynamicCodingKey {
    func decodeIgnoringCase<T>(_ type: T.Type, forKey key: CompoundWordStyle) throws -> T where T : Decodable {
        var errors: [Error] = []
        do {
            return try self.decode(type, forKey: DynamicCodingKey.makeKey(key.pascalCase))
        }
        catch {
            errors.append(error)
            do {
                return try self.decode(type, forKey: DynamicCodingKey.makeKey(key.lowerCamelCase))
            }
            catch {
                errors.append(error)
                throw MultipleError(errors: errors)
            }
        }
    }

    func decodeIfPresentIgnoringCase<T>(_ type: T.Type, forKey key: CompoundWordStyle) throws -> T? where T : Decodable {
        var errors: [Error] = []
        var result: T?
        
        do {
            result = try self.decodeIfPresent(type, forKey: DynamicCodingKey.makeKey(key.pascalCase))
        }
        catch {
            errors.append(error)
        }
        
        if result == nil {
            do {
                result = try self.decodeIfPresent(type, forKey: DynamicCodingKey.makeKey(key.lowerCamelCase))
            }
            catch {
                errors.append(error)
            }
        }
        
        if errors.count > 0 {
            throw MultipleError(errors: errors)
        }
        
        return result
    }
}
