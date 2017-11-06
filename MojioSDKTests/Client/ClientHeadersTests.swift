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

@testable import MojioSDK
import XCTest

class ClientHeadersTests: XCTestCase {
    func testShouldReturnDefaultRequestHeaders() {
        let languages = ["en", "uk-UA"]
        let clientHeader = ClientHeaders(languages: languages)
        
        let headers = clientHeader.defaultRequestHeaders
        
        XCTAssertEqual(headers["Accept-Language"], "en, uk-UA;q=0.9")
    }
    
    func testShouldReturnDefaultRequestHeadersFromFirstSixLanguages() {
        let clientHeader = ClientHeaders(languages: ["en", "uk-UA", "en-GB", "ru-RU", "da", "en-CA", "en-AU"])
        
        let headers = clientHeader.defaultRequestHeaders
        
        XCTAssertEqual(headers["Accept-Language"], "en, uk-UA;q=0.9, en-GB;q=0.8, ru-RU;q=0.7, da;q=0.6, en-CA;q=0.5")
    }
    
    func testShouldReturnEnglishIfLanguagesCountIsZero() {
        let clientHeader = ClientHeaders(languages: [])
        
        let headers = clientHeader.defaultRequestHeaders
        
        XCTAssertEqual(headers["Accept-Language"], "en")
    }
}
