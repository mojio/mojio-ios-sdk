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
    
    func testParseTargetAsLocation() {
        let data = Fixtures.targetAsLocation.data(using: .utf8)!
        let decoder = JSONDecoder()
        let event = try! decoder.decode(RootActivity.self, from: data)
        
        XCTAssertNotNil(event.location)
        XCTAssertTrue(event.location!.hasCoordinate)
        XCTAssertNil(event.target)
    }
    
    
    func testParseTripStartedTimelineActivity() {
        let data = Fixtures.startTripTimelineActivity.data(using: .utf8)!
        let decoder = JSONDecoder()
        let event = try! decoder.decode(RootActivity.self, from: data)
        
        XCTAssertNotNil(event.location)
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
        static let targetAsLocation = """
{
  "id": "9e5b42a5-77b7-e3df-8a3f-a5c0a6717ab4",
  "type": "Arrive",
  "timelineType": "TripCompleted",
  "name": "Trip Completed",
  "summary": "Your vehicle has just completed a trip from М12, Khmel'nyts'ka oblast, Ukraine to Unnamed Road, Kyiv, Ukraine, 02000.",
  "actor": {
    "type": "Vehicle",
    "id": "1f77bfa5-ea88-4692-a3c7-18e1df01db4c"
  },
  "origin": {
    "latitude": 49.36207,
    "longitude": 27.03641,
    "altitude": 0,
    "type": "Place",
    "name": "М12, Khmel'nyts'ka oblast, Ukraine"
  },
  "target": {
    "latitude": 50.4518,
    "longitude": 30.55403,
    "altitude": 0,
    "type": "Place",
    "name": "Unnamed Road, Kyiv, Ukraine, 02000"
  },
  "result": {
    "duration": "01:08:39.6600000",
    "polyline": "",
    "tags": [],
    "type": "Trip",
    "id": "0d30c0bb-0dfd-444b-8edc-7bf838185747"
  },
  "startTime": "2018-07-24T13:14:36.000Z",
  "published": "2018-07-24T13:14:36.000Z"
}
"""
        static let startTripTimelineActivity = """
{
  "id": "8c13607d-075d-9b89-47a3-1f4d632ae2a4",
  "type": "Leave",
  "timelineType": "TripStarted",
  "name": "Trip Started",
  "summary": "Your vehicle has just started a trip from Canada.",
  "actor": {
    "type": "Vehicle",
    "id": "3d803c23-c499-4f65-95cf-56c4b617fdbd"
  },
  "location": {
    "latitude": 45,
    "longitude": -73,
    "altitude": 69,
    "type": "Place",
    "name": "Canada"
  },
  "result": {
    "type": "Trip",
    "id": "6eed2bf1-aa6f-4cad-984a-7a5d2a734b9e"
  },
  "startTime": "2018-08-09T13:39:16.000Z",
  "published": "2018-08-09T13:39:16.000Z"
}
"""
    }
}
