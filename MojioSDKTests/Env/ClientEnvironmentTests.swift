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

class ClientEnvironmentTests: XCTestCase {
    func testMojioRegionDescription() {
        let regionDescription = "eu-develop-"
        let region = MojioRegionStub(.develop)
        
        XCTAssertEqual(region.description, regionDescription)
    }
    
    func testDomainFromMojioEndpointWithDefaultRegion() {
        let env = ClientEnvironment()
        
        let apiDomain = env.domainFromMojioEndpoint(.api)
        let pushDomain = env.domainFromMojioEndpoint(.push)
        let webSocketPushDomain = env.domainFromMojioEndpoint(.wsPush)
        let myMojioDomain = env.domainFromMojioEndpoint(.myMojio)
        let identityDomain = env.domainFromMojioEndpoint(.identity)

        XCTAssertEqual(apiDomain, "api.moj.io")
        XCTAssertEqual(pushDomain, "push.moj.io")
        XCTAssertEqual(webSocketPushDomain, "api.moj.io")
        XCTAssertEqual(myMojioDomain, "my.moj.io")
        XCTAssertEqual(identityDomain, "identity.moj.io")
    }
    
    func testDomainFromMojioEndpointWithRegions() {
        let env = ClientEnvironment()
        let region = MojioRegionStub(.develop)

        env.setRegion(region)

        let apiDomain = env.domainFromMojioEndpoint(.api)
        let pushDomain = env.domainFromMojioEndpoint(.push)
        let webSocketPushDomain = env.domainFromMojioEndpoint(.wsPush)
        let myMojioDomain = env.domainFromMojioEndpoint(.myMojio)
        let identityDomain = env.domainFromMojioEndpoint(.identity)

        XCTAssertEqual(apiDomain, "eu-develop-api.moj.io")
        XCTAssertEqual(pushDomain, "eu-develop-push.moj.io")
        XCTAssertEqual(webSocketPushDomain, "eu-develop-api.moj.io")
        XCTAssertEqual(myMojioDomain, "eu-develop-my.moj.io")
        XCTAssertEqual(identityDomain, "eu-develop-identity.moj.io")
    }
    
    func testClientEnvironmentRegionChanges() {
        let env = ClientEnvironment()
        let region = MojioRegion(.develop)
        
        env.setRegion(region)
        let developRegion = env.getRegion()
        
        env.setDefaultRegion()
        let defaultRegion = env.getRegion()
        
        XCTAssertEqual(developRegion.regionType, .develop)
        XCTAssertEqual(defaultRegion.regionType, .production)
    }
    
    func testClientEnvironmentEndpoints() {
        let env = ClientEnvironment()
        let region = MojioRegionStub(.develop)
        
        env.setRegion(region)
        
        let apiEndpoint = env.getApiEndpoint()
        let v1ApiEndpoint = env.getV1ApiEndpoint()
        let pushApnsEndpoint = env.getPushApnsEndpoint()
        let webSocketPushEndpoint = env.getPushWSEndpoint()
        let myMojioEndpoint = env.getMyMojioEndpoint()
        let identityEndpoint = env.getIdentityEndpoint()
        
        XCTAssertEqual(apiEndpoint, "https://eu-develop-api.moj.io/v2/")
        XCTAssertEqual(v1ApiEndpoint, "https://eu-develop-api.moj.io/v1/")
        XCTAssertEqual(pushApnsEndpoint, "https://eu-develop-push.moj.io/v2/")
        XCTAssertEqual(webSocketPushEndpoint, "wss://eu-develop-api.moj.io/v2/")
        XCTAssertEqual(myMojioEndpoint, "https://eu-develop-my.moj.io/")
        XCTAssertEqual(identityEndpoint, "https://eu-develop-identity.moj.io/")
    }
    
    class MojioRegionStub: MojioRegion {
        override var regionPrefix: String {
            return "eu-"
        }
    }
}
