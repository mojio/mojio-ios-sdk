//
//  ClientTest.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-29.
//  Copyright © 2016 Mojio. All rights reserved.
//

import XCTest
import ObjectMapper
import OHHTTPStubs

@testable import MojioSDK

class ClientTests: XCTestCase {
    
    private let PATH_APPS : String = "apps/"
    private let PATH_SECRET : String = "secret/"
    private let PATH_GROUPS : String = "groups/"
    private let PATH_USERS : String = "users/"
    private let PATH_ME : String = "me/"
    private let PATH_HISTORY : String = "history/"
    private let PATH_STATES : String = "states/"
    private let PATH_LOCATIONS : String = "locations/"
    private let PATH_IMAGE : String = "image/"
    private let PATH_MOJIOS : String = "mojios/"
    private let PATH_PERMISSION : String = "permission/"
    private let PATH_PERMISSIONS : String = "permissions/"
    private let PATH_TAGS : String = "tags/"
    private let PATH_TRIPS : String = "trips/"
    private let PATH_VEHICLES : String = "vehicles/"
    private let PATH_ADDRESS : String = "address/"
    private let PATH_VIN : String = "vin/"
    private let PATH_SERVICE_SCHEDULE = "serviceschedule/"
    private let PATH_NEXT : String = "next/"
    
    override func setUp() {
        super.setUp()
        ClientEnvironment.SharedInstance.setRegion(MojioRegion.NAStaging)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        OHHTTPStubs.removeAllStubs()
    }
    
    func testObjectSerialization () {
        
        let client : RestClient = RestClient()
       
        client.requestEntity = RestClientEndpoints.Vehicles
        let vehicle = client.parseDict (toDict("VehicleData")!)
        
        client.requestEntity = RestClientEndpoints.States
        let states = client.parseDict(toDict("VehicleStateData")!)

        client.requestEntity = RestClientEndpoints.Apps
        let app = client.parseDict (toDict("AppData")!) as? App
        
        client.requestEntity = RestClientEndpoints.Mojios
        let mojio = client.parseDict (toDict("MojioData")!) as? Mojio
        
        client.requestEntity = RestClientEndpoints.Trips
        let trip = client.parseDict (toDict("TripData")!) as? Trip
        
        client.requestEntity = RestClientEndpoints.Users
        let user = client.parseDict (toDict("UserData")!) as? User
        
        client.requestEntity = RestClientEndpoints.Vin
        let vin = client.parseDict(toDict("VinData")!) as? Vin

        client.requestEntity = RestClientEndpoints.ServiceSchedule
        let serviceSchedule = client.parseDict(toDict("ServiceScheduleData")!) as? ServiceSchedule
        
        client.requestEntity = RestClientEndpoints.Next
        let nextService = client.parseDict(toDict("NextServiceData")!) as? NextServiceSchedule
        
        client.requestEntity = RestClientEndpoints.Groups
        let group = client.parseDict(toDict("GroupData")!) as? Group

        client.requestEntity = RestClientEndpoints.Activities
        let activities = toArray(client, fileName: "VehicleActivityData")
        //let activity = client.parseDict(toDict("VehicleActivityData")!) as? Activity

        XCTAssertNotNil((vehicle?.isKindOfClass(Vehicle)), "The class is not of type vehicle")
        XCTAssertNotNil((states?.isKindOfClass(VehicleMeasures)), "The class is not of type vehicle measure")
        XCTAssertNotNil((app?.isKindOfClass(App)), "The class is not of type app")
        XCTAssertNotNil((mojio?.isKindOfClass(Mojio)), "The class is not of type mojio")
        XCTAssertNotNil((trip?.isKindOfClass(Trip)), "The class is not of type trip")
        XCTAssertNotNil((user?.isKindOfClass(User)), "The class is not of type user")
        XCTAssertNotNil((vin?.isKindOfClass(Vin)), "The class is not of type VIN")
        XCTAssertNotNil((serviceSchedule?.isKindOfClass(ServiceSchedule)), "The class is not of type ServiceSchedule")
        XCTAssertNotNil((nextService?.isKindOfClass(NextServiceSchedule)), "The class is not of type Next Service")
        XCTAssertNotNil((group?.isKindOfClass(Group)), "The class is not of type Group")

        XCTAssertNotNil(activities, "Activities not read")

        XCTAssertNotNil(vehicle?.jsonDict(), "Could not serialize vehicle into JSON")
        XCTAssertNotNil(app?.json(), "Could not serialize app into JSON")
        XCTAssertNotNil(mojio?.json(), "Could not serialize Mojio into JSON")
        XCTAssertNotNil(trip?.json(), "Could not serialize trip into JSON")
        XCTAssertNotNil(user?.jsonDict(), "Could not serialize user into JSON")
        
    }
    
    func testGetObject () {
        self.executeRestRequest("VehicleData.txt", message: "Failed to fetch vehicle", requestType : "GET")
    }
    
    func testGetObjects () {
        self.executeRestRequest("VehiclesData.txt", message: "Failed to fetch all vehicles", requestType : "GET")
    }
    
    func testPutObject () {
        self.executeRestRequest("VehicleData.txt", message: "Failed to post vehicle", requestType : "PUT")
    }
    
    func testPostObject () {
        self.executeRestRequest("VehicleData.txt", message: "Failed to post vehicle", requestType : "POST")
    }
    
    func testDeleteObject () {
        self.executeRestRequest("VehicleData.txt", message: "Failed to delete vehicle", requestType: "DELETE")
    }
    
    func executeRestRequest (fileName : String, message : String, requestType : String) {
        
        stub(isHost("na-staging-api.moj.io")) { _ in
            let stubPath = OHPathForFile (fileName, self.dynamicType)
            return fixture(stubPath!, headers : ["Content-Type" : "application/json"])
        }
        
        let expectation = self.expectationWithDescription("Response arrived")
        
        if requestType == "GET" {
            RestClient().get().vehicles(nil).query("1", skip: "2", filter: "vehicleId=vehicleId", select: "", orderby: "").run({ response in
                expectation.fulfill()
                
                }, failure: { error in
                    XCTAssertFalse(false, message)
            })
        }
        else if requestType == "PUT" {
            RestClient().put().users("user-id").run({ response in
                expectation.fulfill()
                }, failure: { error in
                    XCTAssertFalse(false, message)
            })
        }
        else if requestType == "POST" {
            RestClient().post().vehicles(nil).run({ response in
                expectation.fulfill()
                }, failure: { error in
                    XCTAssertFalse(false, message)
            })
        }
        else if requestType == "DELETE" {
            RestClient().delete().vehicles("vehicleId").run({ response in
                expectation.fulfill()
                }, failure: { error in
                    XCTAssertFalse(false, message)
            })
        }

        self.waitForExpectationsWithTimeout(5, handler: nil)
    }
    
    func toDict (fileName : String) -> NSDictionary? {
        
        let path = NSBundle(forClass: ClientTests.self).pathForResource(fileName, ofType: "txt")
        let text = try! NSString (contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        let data = text.dataUsingEncoding(NSUTF8StringEncoding)
        let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String : AnyObject]
        
        return dict
    }
    
    func toArray (client : RestClient, fileName : String) -> NSMutableArray? {
        if let responseDict = toDict(fileName) {
            if let dataArray : NSArray = responseDict.objectForKey("Data") as? NSArray {
                let array : NSMutableArray = []
                for  obj in dataArray {
                    array.addObject(client.parseDict(obj as! NSDictionary)!)
                }
                return array
            }
        }
        return nil
    }
}
