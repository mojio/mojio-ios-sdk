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
import MojioCore

class ActivityTests: XCTestCase {
    func testParseDisturbanceEvent() {
        let data = Fixtures.disturbanceEvent.data(using: .utf8)!
        let decoder = JSONDecoder()
        let event = try! decoder.decode(RootActivity.self, from: data)
        
        XCTAssertNotNil(event.actor)
        XCTAssertNotNil(event.target)
        XCTAssertNotNil(event.location)
    }
    
    func testParseTarget() {
        let data = Fixtures.targetEvent.data(using: .utf8)!
        let decoder = JSONDecoder()
        let event = try! decoder.decode(Activity.self, from: data)

        XCTAssertNotNil(event.id)
        XCTAssertNotNil(event.href)
        XCTAssertNotNil(event.location)
    }
    
    func testParseLocation() {
        let data = Fixtures.location.data(using: .utf8)!
        let decoder = JSONDecoder()
        let event = try! decoder.decode(ActivityLocation.self, from: data)
        
        XCTAssertNotNil(event.latitude)
        XCTAssertNotNil(event.altitude)
        XCTAssertNotNil(event.longitude)
        XCTAssertNotNil(event.name)
        XCTAssertNotNil(event.type)
    }
    
    func testParseLocationCamel() {
        let data = Fixtures.locationCamel.data(using: .utf8)!
        let decoder = JSONDecoder()
        let event = try! decoder.decode(ActivityLocation.self, from: data)
        
        XCTAssertNotNil(event.latitude)
        XCTAssertNotNil(event.altitude)
        XCTAssertNotNil(event.longitude)
        XCTAssertNotNil(event.name)
        XCTAssertNotNil(event.type)
    }
    
    struct Fixtures {
        static let disturbanceEvent = """
{
  "id": "51183a95-0efb-4f37-b2a5-f2631971a0e4",
  "TenantId": "35af7688-4ed3-465f-be9f-e68247bcaf34",
  "PublishedEpoch": 1532174903062,
  "Actor": {
    "HRef": "https://api.moj.io/v2/Persons/7f7e6eec-8f2e-4d00-8ced-e22949e21cda",
    "Name": "Prokhor",
    "Type": "Person",
    "Id": "7f7e6eec-8f2e-4d00-8ced-e22949e21cda",
    "Context": "http://www.w3.org/ns/activitystreams#Person",
    "SummaryMap": {}
  },
  "Target": {
    "HRef": "https://api.moj.io/v2/Vehicles/9b44c6e1-fff0-4469-9401-c461feae64ae",
    "Type": "Vehicle",
    "Id": "9b44c6e1-fff0-4469-9401-c461feae64ae",
    "Location": {
      "Longitude": -79.1302,
      "Latitude": 43.84237,
      "Altitude": 0,
      "Name": "686 Sunbird Trail, Pickering, ON L1X 2X6, Canada",
      "Type": "Location"
    }
  },
  "Groups": [
    "7f7e6eec-8f2e-4d00-8ced-e22949e21cda"
  ],
  "UserId": "7f7e6eec-8f2e-4d00-8ced-e22949e21cda",
  "Id": "51183a95-0efb-4f37-b2a5-f2631971a0e4",
  "Context": "http://www.w3.org/ns/activitystreams#Move",
  "Type": "Move",
  "Name": "Possible Disturbance Has Been Detected",
  "NameMap": {
    "en": "Possible Disturbance Has Been Detected",
    "cs": "Otřesy zaparkovaného auta",
    "fr": "Possibilité de perturbation détectée",
    "de": "Mögliche Fremdeinwirkung wurde festgestellt.",
    "es": "Se detectó una posible perturbación."
  },
  "Location": {
    "Longitude": -79.1302,
    "Latitude": 43.84237,
    "Altitude": 0,
    "Name": "686 Sunbird Trail, Pickering, ON L1X 2X6, Canada",
    "Type": "Location"
  },
  "Published": "2018-07-21T12:08:23.062Z",
  "StartTime": "2018-07-21T12:08:22.874Z",
  "SummaryMap": {
    "en": "A disturbance has been recorded for your vehicle.",
    "cs": "U auto jsme zaznamenali otřesy. Mohou znamenat pokus o vloupání do vozu, nabourání vozu, prudké zabouchnutí dveří, či jinou podobnou událost.",
    "fr": "Une perturbation a été enregistrée pour votre véhicule.",
    "de": "Es wurde eine Störung für Ihr „Fahrzeug“ verzeichnet.",
    "es": "Se registró una perturbación en su vehí­culo."
  }
}
"""
        static let targetEvent = """
{
    "HRef": "https://api.moj.io/v2/Vehicles/9b44c6e1-fff0-4469-9401-c461feae64ae",
    "Type": "Vehicle",
    "Id": "9b44c6e1-fff0-4469-9401-c461feae64ae",
    "Location": {
      "Longitude": -79.1302,
      "Latitude": 43.84237,
      "Altitude": 0,
      "Name": "686 Sunbird Trail, Pickering, ON L1X 2X6, Canada",
      "Type": "Location"
    }
}
"""
        
        static let location = """
{
    "Longitude": -79.1302,
    "Latitude": 43.84237,
    "Altitude": 0,
    "Name": "686 Sunbird Trail, Pickering, ON L1X 2X6, Canada",
    "Type": "Location"
}
"""
        
        static let locationCamel = """
{
    "longitude": -79.1302,
    "latitude": 43.84237,
    "altitude": 0,
    "name": "686 Sunbird Trail, Pickering, ON L1X 2X6, Canada",
    "type": "Location"
}
"""
    }
}
