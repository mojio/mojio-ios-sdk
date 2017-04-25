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

import XCTest
import ObjectMapper
import OHHTTPStubs

@testable import MojioSDK

class ClientTests: XCTestCase {
    
    fileprivate let PATH_APPS : String = "apps/"
    fileprivate let PATH_SECRET : String = "secret/"
    fileprivate let PATH_GROUPS : String = "groups/"
    fileprivate let PATH_USERS : String = "users/"
    fileprivate let PATH_ME : String = "me/"
    fileprivate let PATH_HISTORY : String = "history/"
    fileprivate let PATH_STATES : String = "states/"
    fileprivate let PATH_LOCATIONS : String = "locations/"
    fileprivate let PATH_IMAGE : String = "image/"
    fileprivate let PATH_MOJIOS : String = "mojios/"
    fileprivate let PATH_PERMISSION : String = "permission/"
    fileprivate let PATH_PERMISSIONS : String = "permissions/"
    fileprivate let PATH_TAGS : String = "tags/"
    fileprivate let PATH_TRIPS : String = "trips/"
    fileprivate let PATH_VEHICLES : String = "vehicles/"
    fileprivate let PATH_ADDRESS : String = "address/"
    fileprivate let PATH_VIN : String = "vin/"
    fileprivate let PATH_SERVICE_SCHEDULE = "serviceschedule/"
    fileprivate let PATH_NEXT : String = "next/"
    
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
    
    func executeRestRequest (_ fileName : String, message : String, requestType : String) {
        
        stub(isHost("na-staging-api.moj.io")) { _ in
            let stubPath = OHPathForFile (fileName, type(of: self))
            return fixture(stubPath!, headers : ["Content-Type" : "application/json"])
        }
        
        let expectation = self.expectation(description: "Response arrived")
        
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

        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func toDict (_ fileName : String) -> NSDictionary? {
        
        let path = Bundle(for: ClientTests.self).path(forResource: fileName, ofType: "txt")
        let text = try! NSString (contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue)
        let data = text.data(using: String.Encoding.utf8.rawValue)
        let dict = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject]
        
        return dict as NSDictionary?
    }
    
    func toArray (_ client : RestClient, fileName : String) -> NSMutableArray? {
        if let responseDict = toDict(fileName) {
            if let dataArray : NSArray = responseDict.object(forKey: "Data") as? NSArray {
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
