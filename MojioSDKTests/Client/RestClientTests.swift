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
import SwiftDate
import OHHTTPStubs

class RestClientTests: XCTestCase {
    var apiEndpoint: String!
    var pushApiEndpoint: String!
    var apiV1Endpoint: String!
    var client: RestClient!
    var environment: ClientEnvironment!
    let id = "a8fhry37dhea12sj3j"
    let anotherId = "g4nnf56n3j44k2341"
    let key = "key"
    
    override func setUp() {
        super.setUp()
        
        self.environment = ClientEnvironment()
        self.apiEndpoint = self.environment.getApiEndpoint()
        self.apiV1Endpoint = self.environment.getV1ApiEndpoint()
        self.pushApiEndpoint = self.environment.getPushWSEndpoint()
        self.client = RestClient(clientEnvironment: environment)
    }
    
    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        
        super.tearDown()
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
    
    func testRestClientShouldAppendPermissionPathToRequestUrl() {
        _ = self.client.permission()
        
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.permission.rawValue)
        XCTAssertEqual(self.client.requestEntity, .permission)
    }
    
    func testRestClientShouldAppendPermissionsPathToRequestUrl() {
        _ = self.client.permissions()
        
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.permissions.rawValue)
        XCTAssertEqual(self.client.requestEntity, .permissions)
    }
    
    func testRestClientShouldAppendTagsPathToRequestUrl() {
        _ = self.client.tags(id)
        
        XCTAssertEqual(self.client.requestEntity, .tags)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.tags.rawValue + self.id + "/")
    }
    
    func testRestClientShouldAppendTripsPathToRequestUrl() {
        _ = self.client.trips()
        
        XCTAssertEqual(self.client.requestEntity, .trips)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.trips.rawValue)
        XCTAssertEqual(self.client.pushUrl, self.pushApiEndpoint + RestClientEndpoint.trips.rawValue)
    }
    
    func testRestClientShouldAppendTripsPathWithIdToRequestUrl() {
        _ = self.client.trips(self.id)
        
        XCTAssertEqual(self.client.requestEntity, .trips)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.trips.rawValue + self.id + "/")
        XCTAssertEqual(self.client.pushUrl, self.pushApiEndpoint + RestClientEndpoint.trips.rawValue + self.id + "/")
    }
    
    func testRestClientShouldAppendVehiclesPathToRequestUrl() {
        _ = self.client.vehicles()
        
        XCTAssertEqual(self.client.requestEntity, .vehicles)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.vehicles.rawValue)
        XCTAssertEqual(self.client.pushUrl, self.pushApiEndpoint + RestClientEndpoint.vehicles.rawValue)
    }
    
    func testRestClientShouldAppendVehiclesPathWithIdToRequestUrl() {
        _ = self.client.vehicles(self.id)
        
        XCTAssertEqual(self.client.requestEntity, .vehicles)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.vehicles.rawValue + self.id + "/")
        XCTAssertEqual(self.client.pushUrl, self.pushApiEndpoint + RestClientEndpoint.vehicles.rawValue + self.id + "/")
        XCTAssertEqual(self.client.pushUrl, self.pushApiEndpoint + RestClientEndpoint.vehicles.rawValue + self.id + "/")
    }
    
    func testRestClientShouldAppendVehiclesPathWithIdAndParametersToRequestUrl() {
        _ = self.client.vehicles(self.id, mergeVehicleId: self.anotherId)
        
        XCTAssertEqual(self.client.requestEntity, .vehicles)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.vehicles.rawValue + self.id + "/")
        XCTAssertEqual(self.client.pushUrl, self.pushApiEndpoint + RestClientEndpoint.vehicles.rawValue + self.id + "/")
        XCTAssertEqual(self.client.requestParams["actual"] as? String, self.anotherId)
    }
    
    func testRestClientShouldAppendNotificationSettingsPathToRequestUrl() {
        _ = self.client.notificationSettings()
        
        XCTAssertEqual(self.client.requestEntity, .notificationSettings)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.notificationSettings.rawValue)
    }
    
    func testRestClientShouldAppendAddressPathToRequestUrl() {
        _ = self.client.address()
        
        XCTAssertEqual(self.client.requestEntity, .address)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.address.rawValue)
    }
    
    func testRestClientShouldAppendVinPathToRequestUrl() {
        _ = self.client.vin()
        
        XCTAssertEqual(self.client.requestEntity, .vin)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.vin.rawValue)
    }
    
    func testRestClientShouldAppendServiceSchedulePathToRequestUrl() {
        _ = self.client.serviceSchedule()
        
        XCTAssertEqual(self.client.requestEntity, .serviceSchedule)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.serviceSchedule.rawValue)
    }
    
    func testRestClientShouldAppendNextPathToRequestUrl() {
        _ = self.client.next()
        
        XCTAssertEqual(self.client.requestEntity, .next)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.next.rawValue)
    }
    
    func testRestClientShouldAppendStorageKeyToRequestUrl() {
        _ = self.client.vehicles(self.id).storage(self.key)

        let url = "\(self.apiV1Endpoint!)\(RestClientEndpoint.vehicles.rawValue)\(self.id)/store/\(self.key)"
        XCTAssertEqual(self.client.requestEntity, .vehicles)
        XCTAssertEqual(self.client.requestUrl, url)
    }
    
    func testRestClientShouldAppendActivitiesPathToRequestUrl() {
        _ = self.client.activities()
        
        XCTAssertEqual(self.client.requestEntity, .activities)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.activities.rawValue)
        XCTAssertEqual(self.client.pushUrl, self.pushApiEndpoint + RestClientEndpoint.activities.rawValue)
    }
    
    func testRestClientShouldAppendWifiRadioPathToRequestUrl() {
        _ = self.client.wifiRadio()
        
        XCTAssertEqual(self.client.requestEntity, .wifiRadio)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.wifiRadio.rawValue)
    }
    
    func testRestClientShouldAppendTransactionsPathToRequestUrl() {
        _ = self.client.transactions()
        
        XCTAssertEqual(self.client.requestEntity, .transactions)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.transactions.rawValue)
    }
    
    func testRestClientShouldAppendTransactionsPathWithIdToRequestUrl() {
        _ = self.client.transactions(self.id)
        
        XCTAssertEqual(self.client.requestEntity, .transactions)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.transactions.rawValue + self.id + "/")
    }
    
    func testRestClientShouldAppendgeofencesPathToRequestUrl() {
        _ = self.client.geofences()
        
        XCTAssertEqual(self.client.requestEntity, .geofences)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.geofences.rawValue)
        XCTAssertEqual(self.client.pushUrl, self.pushApiEndpoint + RestClientEndpoint.geofences.rawValue)
    }
    
    func testRestClientShouldAppendGeofencesPathWthIdToRequestUrl() {
        _ = self.client.geofences(self.id)
        
        XCTAssertEqual(self.client.requestEntity, .geofences)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.geofences.rawValue + self.id + "/")
        XCTAssertEqual(self.client.pushUrl, self.pushApiEndpoint + RestClientEndpoint.geofences.rawValue + self.id + "/")
    }
    
    func testRestClientShouldAppendAggregatesPathWithIdToRequestUrl() {
        _ = self.client.aggregates()
        
        XCTAssertEqual(self.client.requestEntity, .aggregates)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.aggregates.rawValue)
    }

    func testRestClientShouldAppendAggregatesPathWithTypeWithIdToRequestUrl() {
        let type = "type"
        _ = self.client.aggregates(ofType: type)
        
        XCTAssertEqual(self.client.requestEntity, .aggregates)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.aggregates.rawValue + type + "/")
    }

    func testRestClientShouldAppendStatisticsPathWithIdToRequestUrl() {
        _ = self.client.statistics()
        
        XCTAssertEqual(self.client.requestEntity, .statistics)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.statistics.rawValue)
    }
    
    func testRestClientShouldAppendDiagnosticCodePathToRequestUrl() {
        _ = self.client.diagnosticCodes()
        
        XCTAssertEqual(self.client.requestEntity, .diagnosticCodes)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.diagnosticCodes.rawValue)
    }
    
    func testRestClientShouldAppendDiagnosticPathWithCodeToRequestUrl() {
        let code = "code"
        _ = self.client.diagnosticCodes(code)
        
        XCTAssertEqual(self.client.requestEntity, .diagnosticCodes)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.diagnosticCodes.rawValue + code)
    }
    
    func testRestClientShouldAppendPolylinePathToRequestUrl() {
        _ = self.client.polyline()
        
        XCTAssertEqual(self.client.requestEntity, .polyline)
        XCTAssertEqual(self.client.requestUrl, self.apiEndpoint + RestClientEndpoint.polyline.rawValue)
    }
    
    func testRestClientShouldCreateRequestParametersAfterQueryFuncWasCalled() {
        let top = "10"
        let skip = "25"
        let filter = "filter"
        let select = "select"
        let orderby = "orderby"
        let count = "50"
        let since = Date(timeIntervalSince1970: 0)
        let before = Date(timeIntervalSince1970: 3600)
        let sampleFields = ["Id", "Name"]
        
        _ = self.client.query(top: top, skip: skip, filter: filter, select: select, orderby: orderby, count: count, since: since, before: before, fields: sampleFields)
        let fields = (self.client.requestParams["fields"] as? String).flatMap { $0.split(separator: ",") }?.map { String($0) }

        XCTAssertEqual(self.client.requestParams["top"] as? String, top)
        XCTAssertEqual(self.client.requestParams["skip"] as? String, skip)
        XCTAssertEqual(self.client.requestParams["filter"] as? String, filter)
        XCTAssertEqual(self.client.requestParams["select"] as? String, select)
        XCTAssertEqual(self.client.requestParams["orderby"] as? String, orderby)
        XCTAssertEqual(self.client.requestParams["includeCount"] as? String, count)
        XCTAssertEqual((self.client.requestParams["since"] as? String).flatMap { $0.date(format: DateFormat.iso8601Auto) }?.absoluteDate, since)
        XCTAssertEqual((self.client.requestParams["before"] as? String).flatMap { $0.date(format: DateFormat.iso8601Auto) }?.absoluteDate, before)
        XCTAssertEqual(fields!, sampleFields)
    }
    
    
    func testRestClientShouldReturnAccessToken() {
        let sampleToken = "sample-token"
        let provider = KeychainStorageProviderMock()
        let keychain = KeychainManager(keychain: provider)
        keychain.saveAuthToken(AuthToken(accessToken: sampleToken, expiry: "3600", refreshToken: "refresh-token", uniqueId: ""))
        let client = RestClient(clientEnvironment: ClientEnvironment(), keychainManager: keychain)
        
        let token = client.accessToken()
        
        XCTAssertEqual(sampleToken, token)
    }
}
