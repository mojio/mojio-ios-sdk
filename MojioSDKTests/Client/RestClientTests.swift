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
import Alamofire

class RestClientTests: XCTestCase {
    var apiEndpoint: String!
    var pushApiEndpoint: String!
    var client: RestClient!
    var environment: ClientEnvironment!
    let id = "a8fhry37dhea12sj3j"
    
    override func setUp() {
        super.setUp()
        
        self.environment = ClientEnvironment()
        self.apiEndpoint = self.environment.getApiEndpoint()
        self.pushApiEndpoint = self.environment.getPushWSEndpoint()
        self.client = RestClient(clientEnvironment: environment)
    }
    
    func testRestClientShouldAppendPathAndEntityIdToRequestURL() {
        _ = self.client.apps(id)
        
        XCTAssertEqual(self.client.requestEntity, .apps)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.apps.rawValue + id + "/")
    }
    
    func testRestClientShouldAppendPathToRequestURL() {
        _ = self.client.apps()
        
        XCTAssertEqual(self.client.requestEntity, .apps)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.apps.rawValue)
    }
    
    func testRestClientShouldAppendSecretPathToRequestURL() {
        _ = self.client.secret()
        
        XCTAssertEqual(self.client.requestEntity, .secret)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.secret.rawValue)
    }
    
    func testRestClientShouldAppendGroupPathToRequestUrl() {
        
        _ = self.client.groups()
        
        XCTAssertEqual(self.client.requestEntity, .groups)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.groups.rawValue)
    }

    func testRestClientShouldAppendGroupPathAndIdToRequestUrl() {
        
        _ = self.client.groups(id)
        
        XCTAssertEqual(self.client.requestEntity, .groups)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.groups.rawValue + id + "/")
    }
    
    func testRestClientShouldAppendUserPathToUrl() {
        _ = self.client.users()
        
        XCTAssertEqual(self.client.requestEntity, .users)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.users.rawValue)
        XCTAssertEqual(self.client.pushUrl, self.pushApiEndpoint + RestClientEndpoint.users.rawValue)
    }

    func testRestClientShouldAppendUserPathAndEntityIdToUrl() {
        _ = self.client.users(id)
        
        XCTAssertEqual(self.client.requestEntity, .users)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.users.rawValue + id + "/")
        XCTAssertEqual(self.client.pushUrl, self.pushApiEndpoint + RestClientEndpoint.users.rawValue + id + "/")
    }
    
    func testRestClientShouldAddMePathToRequestUrl() {
        _ = self.client.me()
        
        XCTAssertEqual(self.client.requestEntity, .me)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.me.rawValue)
    }
    
    func testRestClientShouldAppendHistoryPathToRequestUrl() {
        _ = self.client.history()
        
        XCTAssertEqual(self.client.requestEntity, .history)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.history.rawValue)
    }
    
    func testRestClientShouldAppendLocationsPathToRequestUrl() {
        _ = self.client.locations()
        
        XCTAssertEqual(self.client.requestEntity, .locations)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.locations.rawValue)
    }
    
    func testRestClientShouldAppendMojioPathToUrl() {
        _ = self.client.mojios()
        
        XCTAssertEqual(self.client.requestEntity, .mojios)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.mojios.rawValue)
        XCTAssertEqual(self.client.pushUrl, self.pushApiEndpoint + RestClientEndpoint.mojios.rawValue)
    }
    
    func testRestClientShouldAppendMojioPathAndEntityIdToUrl() {
        _ = self.client.mojios(id)
        
        XCTAssertEqual(self.client.requestEntity, .mojios)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.mojios.rawValue + id + "/")
        XCTAssertEqual(self.client.pushUrl, self.pushApiEndpoint + RestClientEndpoint.mojios.rawValue + id + "/")
    }
    
    func testRestClientShouldAppendPhoneNumberPathToRequestUrl() {
        _ = self.client.phonenumbers()
        
        XCTAssertEqual(self.client.requestEntity, .phoneNumbers)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.phoneNumbers.rawValue)
    }

    func testRestClientShouldAppendPhonePathWithPhoneNumberToRequestUrl() {
        let phoneNumber = "380554445555"
        _ = self.client.phonenumbers(phoneNumber)
        
        XCTAssertEqual(self.client.requestEntity, .phoneNumbers)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.phoneNumbers.rawValue + phoneNumber)
    }

    func testRestClientShouldAppendPhonePathWithPhoneNumberAndPhoneVerificationToRequestUrl() {
        let phoneNumber = "380554445555"
        _ = self.client.phonenumbers(phoneNumber, sendVerification: true)
        
        XCTAssertEqual(self.client.requestEntity, .phoneNumbers)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.phoneNumbers.rawValue + phoneNumber + "?sendVerification=true")
    }
    
    func testRestClientShouldAppendEmailPathToRequestUrl() {
        _ = self.client.emails()
        
        XCTAssertEqual(self.client.requestEntity, .emails)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.emails.rawValue)
    }
    
    func testRestClientShouldAppendEmailPathWithEmailToRequestUrl() {
        let email = "test@example.com"
        _ = self.client.emails(email)
        
        XCTAssertEqual(self.client.requestEntity, .emails)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.emails.rawValue + email + "/")
    }
}
