/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2018 Copyright Moj.io Inc.
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

public protocol CompoundWordStyle {
    var pascalCase: String { get }
    var lowerCamelCase: String { get }
}

public extension RawRepresentable where Self: CompoundWordStyle, RawValue == String {
    var pascalCase: String {
        return self.rawValue.capitalizedFirstCharacter
    }
    
    var lowerCamelCase: String {
        let value = self.rawValue
        if CharacterSet(charactersIn: value).isSubset(of: CharacterSet.uppercaseLetters.union(CharacterSet.decimalDigits)) {
            // it is an abbreviation so change all letters to lowercase
            return value.lowercased()
        }
        else {
            return value.decapitalizedFirstCharacter
        }
    }
}
