//
//  MojioClientTest.swift
//  sdkv2.0.0
//
//  Created by Ashish Agarwal on 2016-02-29.
//  Copyright © 2016 Mojio. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import sdkv2_0_0

class MojioClientTest: XCTestCase {
    
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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testObjectSerialization () {
        
        let client : MojioClient = MojioClient()
       
        client.ENTITY_REQUESTED = "vehicles/"
        let vehicle = client.parseDict (toDict("VehicleData")!) 

        client.ENTITY_REQUESTED = "apps/"
        let app = client.parseDict (toDict("AppData")!) as? App
        
        client.ENTITY_REQUESTED = "mojios/"
        let mojio = client.parseDict (toDict("MojioData")!) as? Mojio
        
        client.ENTITY_REQUESTED = "trips/"
        let trip = client.parseDict (toDict("TripData")!) as? Trip
        
        client.ENTITY_REQUESTED = "users/"
        let user = client.parseDict (toDict("UserData")!) as? User
        
        client.ENTITY_REQUESTED = self.PATH_VIN
        let vin = client.parseDict(toDict("VinData")!) as? Vin
        
        client.ENTITY_REQUESTED = self.PATH_SERVICE_SCHEDULE
        let serviceSchedule = client.parseDict(toDict("ServiceScheduleData")!) as? ServiceSchedule
        
        client.ENTITY_REQUESTED = self.PATH_NEXT
        let nextService = client.parseDict(toDict("NextServiceData")!) as? NextServiceSchedule

        XCTAssertNotNil((vehicle?.isKindOfClass(Vehicle)), "The class is not of type vehicle")
        XCTAssertNotNil((app?.isKindOfClass(App)), "The class is not of type app")
        XCTAssertNotNil((mojio?.isKindOfClass(Mojio)), "The class is not of type mojio")
        XCTAssertNotNil((trip?.isKindOfClass(Trip)), "The class is not of type trip")
        XCTAssertNotNil((user?.isKindOfClass(User)), "The class is not of type user")
        XCTAssertNotNil((vin?.isKindOfClass(Vin)), "The class is not of type VIN")
        XCTAssertNotNil((serviceSchedule?.isKindOfClass(ServiceSchedule)), "The class is not of type ServiceSchedule")
        XCTAssertNotNil((nextService?.isKindOfClass(NextServiceSchedule)), "The class is not of type Next Service")
        
        XCTAssertNotNil(vehicle?.json(), "Could not serialize vehicle into JSON")
        XCTAssertNotNil(app?.json(), "Could not serialize app into JSON")
        XCTAssertNotNil(mojio?.json(), "Could not serialize Mojio into JSON")
        XCTAssertNotNil(trip?.json(), "Could not serialize trip into JSON")
        XCTAssertNotNil(user?.json(), "Could not serialize user into JSON")
        
    }
    
    func testCrud () {
        
    }
    
    
    func toDict (fileName : String) -> NSDictionary? {
        
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt")
        let text = try! NSString (contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        let data = text.dataUsingEncoding(NSUTF8StringEncoding)
        let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String : AnyObject]
        
        return dict
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
