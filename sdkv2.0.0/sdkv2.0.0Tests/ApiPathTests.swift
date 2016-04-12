//
//  PathTest.swift
//  sdkv2.0.0
//
//  Created by Ashish Agarwal on 2016-02-29.
//  Copyright © 2016 Mojio. All rights reserved.
//

import XCTest

class ApiPathTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        MojioClientEnvironment.sharedInstance.setRegion(MojioClientRegion.NAStaging)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testVehiclePaths () {
        
        let vehicleId : String = "eff1ccd0-e718-4e28-a985-945a2994f689"
        let vehiclesPath : NSString = (MojioClient().vehicles(nil)).requestUrl!
        let vehicleIdPath : NSString = (MojioClient().vehicles("\(vehicleId)")).requestUrl!
        let vehicleAddressPath : NSString = (MojioClient().vehicles("\(vehicleId)").address()).requestUrl!
        let vehicleTripsPath : NSString = (MojioClient().vehicles("\(vehicleId)").trips(nil)).requestUrl!
        let vehicleVinPath : NSString = (MojioClient().vehicles("\(vehicleId)").vin()).requestUrl!
        
        let vehicleServiceSchedulePath : NSString = MojioClient().vehicles("\(vehicleId)").serviceSchedule().requestUrl!
        
        let vehicleNextServicePath : NSString = (MojioClient().vehicles("\(vehicleId)").next()).requestUrl!
        
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
        
        let usersPath : NSString = (MojioClient().users(nil)).requestUrl!
        let userIdPath : NSString = (MojioClient().users("\(userId)")).requestUrl!
        let userVehiclesPath : NSString = (MojioClient().users("\(userId)").vehicles(nil)).requestUrl!
        let userMojiosPath : NSString = (MojioClient().users("\(userId)").mojios(nil)).requestUrl!
        let userGroupsPath : NSString = (MojioClient().users("\(userId)").groups(nil)).requestUrl!
        
        XCTAssertTrue(usersPath.isEqualToString("https://staging-api.moj.io/v2/users/"), "The path to get all users is incorrect")
        
        XCTAssertTrue(userIdPath.isEqualToString("https://staging-api.moj.io/v2/users/\(userId)/"), "The path to get all users is incorrect")
        
        XCTAssertTrue(userVehiclesPath.isEqualToString("https://staging-api.moj.io/v2/users/\(userId)/vehicles/"), "The path to get all users is incorrect")
        
        XCTAssertTrue(userMojiosPath.isEqualToString("https://staging-api.moj.io/v2/users/\(userId)/mojios/"), "The path to get all users is incorrect")
        
        XCTAssertTrue(userGroupsPath.isEqualToString("https://staging-api.moj.io/v2/users/\(userId)/groups/"), "The path to get all users is incorrect")
        
    }
    
    func testTripsPaths () {
        let tripId : NSString = "trip-id"
        
        let tripsPath : NSString = (MojioClient().trips(nil)).requestUrl!
        let tripIdPath : NSString = (MojioClient().trips("\(tripId)")).requestUrl!
        
        XCTAssertTrue(tripsPath.isEqualToString("https://staging-api.moj.io/v2/trips/"), "The path to get all trips is incorrect")
        
        XCTAssertTrue(tripIdPath.isEqualToString("https://staging-api.moj.io/v2/trips/\(tripId)/"), "The path to get a trip with id is incorrect")
    }
    
    func testTagsPaths () {
        let tagId : NSString = "tag-id"
        let resourceId : NSString = "resource-id"
        
        let tagPath : NSString = (MojioClient().trips("\(resourceId)").tags("\(tagId)")).requestUrl!
                
        XCTAssertTrue(tagPath.isEqualToString("https://staging-api.moj.io/v2/trips/\(resourceId)/tags/\(tagId)/"), "The path to get tags is incorrect")
        
    }
    
    func testPermissionsPaths () {
        let permissionId : NSString = "permission-id"
        let resourceId : NSString = "resource-id"
        
        let permissionPath : NSString = (MojioClient().trips("\(resourceId)").tags("\(permissionId)")).requestUrl!
        
        XCTAssertTrue(permissionPath.isEqualToString("https://staging-api.moj.io/v2/trips/\(resourceId)/tags/\(permissionId)/"), "The path to get tags is incorrect")

    }
    
    func testMojiosPaths () {
        let mojioId : NSString = "mojio-id"
        
        let mojiosPath : NSString = (MojioClient().mojios(nil)).requestUrl!
        let mojioIdPath : NSString = (MojioClient().mojios("\(mojioId)")).requestUrl!
        
        XCTAssertTrue(mojiosPath.isEqualToString("https://staging-api.moj.io/v2/mojios/"), "The path to get all mojios is incorrect")
        XCTAssertTrue(mojioIdPath.isEqualToString("https://staging-api.moj.io/v2/mojios/\(mojioId)/"), "The path to get a mojio is incorrect")
    }
    
    func testImagesPaths () {
        let appId : NSString = "app-id"
        let userId : NSString = "user-id"
        let vehicleId : NSString = "vehicle-id"
        
        let appImagePath : NSString = (MojioClient().apps("\(appId)").image()).requestUrl!
        let userImagePath : NSString = (MojioClient().users("\(userId)").image()).requestUrl!
        let vehicleImagePath : NSString = (MojioClient().vehicles("\(vehicleId)").image()).requestUrl!
        
        XCTAssertTrue(appImagePath.isEqualToString("https://staging-api.moj.io/v2/apps/\(appId)/image/"), "The path to get an app's image is incorrect")
        XCTAssertTrue(userImagePath.isEqualToString("https://staging-api.moj.io/v2/users/\(userId)/image/"), "The path to get an app's image is incorrect")
        XCTAssertTrue(vehicleImagePath.isEqualToString("https://staging-api.moj.io/v2/vehicles/\(vehicleId)/image/"), "The path to get an app's image is incorrect")

    }
    
    func testGroupsPaths () {
        let groupId : NSString = "group-id"
        let groupsPath : NSString = (MojioClient().groups(nil)).requestUrl!
        let groupIdPath : NSString = (MojioClient().groups("\(groupId)")).requestUrl!
        let groupUsersPath : NSString = (MojioClient().groups("\(groupId)").users(nil)).requestUrl!
        
        XCTAssertTrue(groupsPath.isEqualToString("https://staging-api.moj.io/v2/groups/"), "The path to get groups is incorrect")
        XCTAssertTrue(groupIdPath.isEqualToString("https://staging-api.moj.io/v2/groups/\(groupId)/"), "The path to get a group is incorrect")
        XCTAssertTrue(groupUsersPath.isEqualToString("https://staging-api.moj.io/v2/groups/\(groupId)/users/"), "The path to get groups is incorrect")

    }
    
    func testAppsPaths () {
        let appId : NSString = "app-id"
        let appsPath : NSString = (MojioClient().apps(nil)).requestUrl!
        let appIdPath : NSString = (MojioClient().apps("\(appId)")).requestUrl!
        let appSecretPath : NSString = (MojioClient().apps("\(appId)").secret()).requestUrl!
        
        XCTAssertTrue(appsPath.isEqualToString("https://staging-api.moj.io/v2/apps/"), "The path to get the apps is incorrect")
        XCTAssertTrue(appIdPath.isEqualToString("https://staging-api.moj.io/v2/apps/\(appId)/"), "The path to get an app is incorrect")
        XCTAssertTrue(appSecretPath.isEqualToString("https://staging-api.moj.io/v2/apps/\(appId)/secret/"), "The path to get an app's secret is incorrect")

    }
    
    
}
