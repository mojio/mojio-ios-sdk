//
//  PathTest.swift
//  sdkv2.0.0
//
//  Created by Ashish Agarwal on 2016-02-29.
//  Copyright © 2016 Mojio. All rights reserved.
//

import XCTest

class PathTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testVehiclePaths () {
        
        let vehicleId : String = "eff1ccd0-e718-4e28-a985-945a2994f689"
        let vehiclesPath : NSString = (MojioClient().vehicles(nil)).REQUEST_URL
        let vehicleIdPath : NSString = (MojioClient().vehicles("\(vehicleId)")).REQUEST_URL
        let vehicleAddressPath : NSString = (MojioClient().vehicles("\(vehicleId)").address()).REQUEST_URL
        let vehicleTripsPath : NSString = (MojioClient().vehicles("\(vehicleId)").trips(nil)).REQUEST_URL
        let vehicleVinPath : NSString = (MojioClient().vehicles("\(vehicleId)").vin()).REQUEST_URL
        
        let vehicleServiceSchedulePath : NSString = (MojioClient().vehicles("\(vehicleId)").serviceschedule()).REQUEST_URL
        let vehicleNextServicePath : NSString = (MojioClient().vehicles("\(vehicleId)").next()).REQUEST_URL
        
        XCTAssertTrue(vehiclesPath.isEqualToString("https://staging-api.moj.io/v2/vehicles/"), "The path to get all vehicles is not correct")
        
        XCTAssertTrue(vehicleIdPath.isEqualToString("https://staging-api.moj.io/v2/vehicles/\(vehicleId)/"), "The path to get a vehicle with vehicle id is incorrect")
        
        XCTAssertTrue(vehicleTripsPath.isEqualToString("https://staging-api.moj.io/v2/vehicles/\(vehicleId)/trips/"), "The path to get a vehicle's trips is incorrect")
        
        XCTAssertTrue(vehicleVinPath.isEqualToString("https://staging-api.moj.io/v2/vehicles/\(vehicleId)/vin/"), "The path to get a vehicle's VIN details incorrect")
        
        XCTAssertTrue(vehicleAddressPath.isEqualToString("https://staging-api.moj.io/v2/vehicles/\(vehicleId)/address/"), "The path to get a vehicle address is incorrect")
        
        XCTAssertTrue(vehicleServiceSchedulePath.isEqualToString("https://staging-api.moj.io/v2/vehicles/\(vehicleId)/serviceschedule/"), "The path to get a vehicle's service schedule is incorrect")
        
        XCTAssertTrue(vehicleNextServicePath.isEqualToString("https://staging-api.moj.io/v2/vehicles/\(vehicleId)/next/"), "The path to get a vehicle's service schedule is incorrect")
        
    }
    
    func testUserPaths () {
        let userId : String = "user-id"
        
        let usersPath : NSString = (MojioClient().users(nil)).REQUEST_URL
        let userIdPath : NSString = (MojioClient().users("\(userId)")).REQUEST_URL
        let userVehiclesPath : NSString = (MojioClient().users("\(userId)").vehicles(nil)).REQUEST_URL
        let userMojiosPath : NSString = (MojioClient().users("\(userId)").mojios(nil)).REQUEST_URL
        let userGroupsPath : NSString = (MojioClient().users("\(userId)").groups(nil)).REQUEST_URL
        
        XCTAssertTrue(usersPath.isEqualToString("https://staging-api.moj.io/v2/users/"), "The path to get all users is incorrect")
        
        XCTAssertTrue(userIdPath.isEqualToString("https://staging-api.moj.io/v2/users/\(userId)/"), "The path to get all users is incorrect")
        
        XCTAssertTrue(userVehiclesPath.isEqualToString("https://staging-api.moj.io/v2/users/\(userId)/vehicles/"), "The path to get all users is incorrect")
        
        XCTAssertTrue(userMojiosPath.isEqualToString("https://staging-api.moj.io/v2/users/\(userId)/mojios/"), "The path to get all users is incorrect")
        
        XCTAssertTrue(userGroupsPath.isEqualToString("https://staging-api.moj.io/v2/users/\(userId)/groups/"), "The path to get all users is incorrect")
        
    }
    
    func testTripsPaths () {
        let tripId : NSString = "trip-id"
        
        let tripsPath : NSString = (MojioClient().trips(nil)).REQUEST_URL
        let tripIdPath : NSString = (MojioClient().trips("\(tripId)")).REQUEST_URL
        
        XCTAssertTrue(tripsPath.isEqualToString("https://staging-api.moj.io/v2/trips/"), "The path to get all trips is incorrect")
        
        XCTAssertTrue(tripIdPath.isEqualToString("https://staging-api.moj.io/v2/trips/\(tripId)/"), "The path to get a trip with id is incorrect")
    }
    
    func testTagsPaths () {
        let tagId : NSString = "tag-id"
        let resourceId : NSString = "resource-id"
        
        let tagPath : NSString = (MojioClient().trips("\(resourceId)").tags("\(tagId)")).REQUEST_URL
                
        XCTAssertTrue(tagPath.isEqualToString("https://staging-api.moj.io/v2/trips/\(resourceId)/tags/\(tagId)/"), "The path to get tags is incorrect")
        
    }
    
    func testPermissionsPaths () {
        let permissionId : NSString = "permission-id"
        let resourceId : NSString = "resource-id"
        
        let permissionPath : NSString = (MojioClient().trips("\(resourceId)").tags("\(permissionId)")).REQUEST_URL
        
        XCTAssertTrue(permissionPath.isEqualToString("https://staging-api.moj.io/v2/trips/\(resourceId)/tags/\(permissionId)/"), "The path to get tags is incorrect")

    }
    
    func testMojiosPaths () {
        let mojioId : NSString = "mojio-id"
        
        let mojiosPath : NSString = (MojioClient().mojios(nil)).REQUEST_URL
        let mojioIdPath : NSString = (MojioClient().mojios("\(mojioId)")).REQUEST_URL
        
        XCTAssertTrue(mojiosPath.isEqualToString("https://staging-api.moj.io/v2/mojios/"), "The path to get all mojios is incorrect")
        XCTAssertTrue(mojioIdPath.isEqualToString("https://staging-api.moj.io/v2/mojios/\(mojioId)/"), "The path to get a mojio is incorrect")
    }
    
    func testImagesPaths () {
        let appId : NSString = "app-id"
        let userId : NSString = "user-id"
        let vehicleId : NSString = "vehicle-id"
        
        let appImagePath : NSString = (MojioClient().apps("\(appId)").image()).REQUEST_URL
        let userImagePath : NSString = (MojioClient().users("\(userId)").image()).REQUEST_URL
        let vehicleImagePath : NSString = (MojioClient().vehicles("\(vehicleId)").image()).REQUEST_URL
        
        XCTAssertTrue(appImagePath.isEqualToString("https://staging-api.moj.io/v2/apps/\(appId)/image/"), "The path to get an app's image is incorrect")
        XCTAssertTrue(userImagePath.isEqualToString("https://staging-api.moj.io/v2/users/\(userId)/image/"), "The path to get an app's image is incorrect")
        XCTAssertTrue(vehicleImagePath.isEqualToString("https://staging-api.moj.io/v2/vehicles/\(vehicleId)/image/"), "The path to get an app's image is incorrect")

    }
    
    func testGroupsPaths () {
        let groupId : NSString = "group-id"
        let groupsPath : NSString = (MojioClient().groups(nil)).REQUEST_URL
        let groupIdPath : NSString = (MojioClient().groups("\(groupId)")).REQUEST_URL
        let groupUsersPath : NSString = (MojioClient().groups("\(groupId)").users(nil)).REQUEST_URL
        
        XCTAssertTrue(groupsPath.isEqualToString("https://staging-api.moj.io/v2/groups/"), "The path to get groups is incorrect")
        XCTAssertTrue(groupIdPath.isEqualToString("https://staging-api.moj.io/v2/groups/\(groupId)/"), "The path to get a group is incorrect")
        XCTAssertTrue(groupUsersPath.isEqualToString("https://staging-api.moj.io/v2/groups/\(groupId)/users/"), "The path to get groups is incorrect")

    }
    
    func testAppsPaths () {
        let appId : NSString = "app-id"
        let appsPath : NSString = (MojioClient().apps(nil)).REQUEST_URL
        let appIdPath : NSString = (MojioClient().apps("\(appId)")).REQUEST_URL
        let appSecretPath : NSString = (MojioClient().apps("\(appId)").secret()).REQUEST_URL
        
        XCTAssertTrue(appsPath.isEqualToString("https://staging-api.moj.io/v2/apps/"), "The path to get the apps is incorrect")
        XCTAssertTrue(appIdPath.isEqualToString("https://staging-api.moj.io/v2/apps/\(appId)/"), "The path to get an app is incorrect")
        XCTAssertTrue(appSecretPath.isEqualToString("https://staging-api.moj.io/v2/apps/\(appId)/secret/"), "The path to get an app's secret is incorrect")

    }
    
    
}
