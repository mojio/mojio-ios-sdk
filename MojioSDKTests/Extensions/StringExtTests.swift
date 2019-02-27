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

import XCTest
import Foundation

class StringExtTests: XCTestCase {
    func testCapitalizedFirstCharacter() {
        let string = "foo"
        let capitalizedString = string.capitalizedFirstCharacter
        
        XCTAssertNotEqual(capitalizedString, string)
        XCTAssertEqual(capitalizedString, "Foo")
    }
    
    func testDecapitalizedFirstCharacter() {
        let string = "FOO"
        let decapitalizedString = string.decapitalizedFirstCharacter
        
        XCTAssertNotEqual(decapitalizedString, string)
        XCTAssertEqual(decapitalizedString, "fOO")
    }
}
