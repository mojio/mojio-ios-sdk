//
//  PathTest.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-29.
//  Copyright © 2016 Mojio. All rights reserved.
//

import XCTest

@testable import MojioSDK

class ApiPathTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        ClientEnvironment.SharedInstance.setRegion(MojioRegion.NAStaging)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testVehiclePaths () {
        
        let vehicleId : String = "eff1ccd0-e718-4e28-a985-945a2994f689"
        let vehiclesPath : NSString = (RestClient().vehicles(nil)).requestUrl!
        let vehicleIdPath : NSString = (RestClient().vehicles("\(vehicleId)")).requestUrl!
        let vehicleAddressPath : NSString = (RestClient().vehicles("\(vehicleId)").address()).requestUrl!
        let vehicleTripsPath : NSString = (RestClient().vehicles("\(vehicleId)").trips(nil)).requestUrl!
        let vehicleVinPath : NSString = (RestClient().vehicles("\(vehicleId)").vin()).requestUrl!
        
        let vehicleServiceSchedulePath : NSString = RestClient().vehicles("\(vehicleId)").serviceSchedule().requestUrl!
        
        let vehicleNextServicePath : NSString = (RestClient().vehicles("\(vehicleId)").next()).requestUrl!
        
        XCTAssertTrue(vehiclesPath.isEqual(to: "https://na-staging-api.moj.io/v2/vehicles/"), "The path to get all vehicles is not correct")
        
        XCTAssertTrue(vehicleIdPath.isEqual(to: "https://na-staging-api.moj.io/v2/vehicles/\(vehicleId)/"), "The path to get a vehicle with vehicle id is incorrect")
        
        XCTAssertTrue(vehicleTripsPath.isEqual(to: "https://na-staging-api.moj.io/v2/vehicles/\(vehicleId)/trips/"), "The path to get a vehicle's trips is incorrect")
        
        XCTAssertTrue(vehicleVinPath.isEqual(to: "https://na-staging-api.moj.io/v2/vehicles/\(vehicleId)/vin/"), "The path to get a vehicle's VIN details incorrect")
        
        XCTAssertTrue(vehicleAddressPath.isEqual(to: "https://na-staging-api.moj.io/v2/vehicles/\(vehicleId)/address/"), "The path to get a vehicle address is incorrect")
        
        XCTAssertTrue(vehicleServiceSchedulePath.isEqual(to: "https://na-staging-api.moj.io/v2/vehicles/\(vehicleId)/serviceschedule/"), "The path to get a vehicle's service schedule is incorrect")
        
        XCTAssertTrue(vehicleNextServicePath.isEqual(to: "https://na-staging-api.moj.io/v2/vehicles/\(vehicleId)/next/"), "The path to get a vehicle's service schedule is incorrect")
        
    }
    
    func testUserPaths () {
        let userId : String = "user-id"
        
        let usersPath : NSString = (RestClient().users(nil)).requestUrl!
        let userIdPath : NSString = (RestClient().users("\(userId)")).requestUrl!
        let userVehiclesPath : NSString = (RestClient().users("\(userId)").vehicles(nil)).requestUrl!
        let userMojiosPath : NSString = (RestClient().users("\(userId)").mojios(nil)).requestUrl!
        let userGroupsPath : NSString = (RestClient().users("\(userId)").groups(nil)).requestUrl!
        
        XCTAssertTrue(usersPath.isEqual(to: "https://na-staging-api.moj.io/v2/users/"), "The path to get all users is incorrect")
        
        XCTAssertTrue(userIdPath.isEqual(to: "https://na-staging-api.moj.io/v2/users/\(userId)/"), "The path to get all users is incorrect")
        
        XCTAssertTrue(userVehiclesPath.isEqual(to: "https://na-staging-api.moj.io/v2/users/\(userId)/vehicles/"), "The path to get all users is incorrect")
        
        XCTAssertTrue(userMojiosPath.isEqual(to: "https://na-staging-api.moj.io/v2/users/\(userId)/mojios/"), "The path to get all users is incorrect")
        
        XCTAssertTrue(userGroupsPath.isEqual(to: "https://na-staging-api.moj.io/v2/users/\(userId)/groups/"), "The path to get all users is incorrect")
        
    }
    
    func testTripsPaths () {
        let tripId : NSString = "trip-id"
        
        let tripsPath : NSString = (RestClient().trips(nil)).requestUrl!
        let tripIdPath : NSString = (RestClient().trips("\(tripId)")).requestUrl!
        
        XCTAssertTrue(tripsPath.isEqual(to: "https://na-staging-api.moj.io/v2/trips/"), "The path to get all trips is incorrect")
        
        XCTAssertTrue(tripIdPath.isEqual(to: "https://na-staging-api.moj.io/v2/trips/\(tripId)/"), "The path to get a trip with id is incorrect")
    }
    
    func testTagsPaths () {
        let tagId : NSString = "tag-id"
        let resourceId : NSString = "resource-id"
        
        let tagPath : NSString = (RestClient().trips("\(resourceId)").tags("\(tagId)")).requestUrl!
                
        XCTAssertTrue(tagPath.isEqual(to: "https://na-staging-api.moj.io/v2/trips/\(resourceId)/tags/\(tagId)/"), "The path to get tags is incorrect")
        
    }
    
    func testPermissionsPaths () {
        let permissionId : NSString = "permission-id"
        let resourceId : NSString = "resource-id"
        
        let permissionPath : NSString = (RestClient().trips("\(resourceId)").tags("\(permissionId)")).requestUrl!
        
        XCTAssertTrue(permissionPath.isEqual(to: "https://na-staging-api.moj.io/v2/trips/\(resourceId)/tags/\(permissionId)/"), "The path to get tags is incorrect")

    }
    
    func testMojiosPaths () {
        let mojioId : NSString = "mojio-id"
        
        let mojiosPath : NSString = (RestClient().mojios(nil)).requestUrl!
        let mojioIdPath : NSString = (RestClient().mojios("\(mojioId)")).requestUrl!
        
        XCTAssertTrue(mojiosPath.isEqual(to: "https://na-staging-api.moj.io/v2/mojios/"), "The path to get all mojios is incorrect")
        XCTAssertTrue(mojioIdPath.isEqual(to: "https://na-staging-api.moj.io/v2/mojios/\(mojioId)/"), "The path to get a mojio is incorrect")
    }
    
    func testImagesPaths () {
        let appId : NSString = "app-id"
        let userId : NSString = "user-id"
        let vehicleId : NSString = "vehicle-id"
        
        let appImagePath : NSString = (RestClient().apps("\(appId)").image()).requestUrl!
        let userImagePath : NSString = (RestClient().users("\(userId)").image()).requestUrl!
        let vehicleImagePath : NSString = (RestClient().vehicles("\(vehicleId)").image()).requestUrl!
        
        XCTAssertTrue(appImagePath.isEqual(to: "https://na-staging-api.moj.io/v2/apps/\(appId)/image/"), "The path to get an app's image is incorrect")
        XCTAssertTrue(userImagePath.isEqual(to: "https://na-staging-api.moj.io/v2/users/\(userId)/image/"), "The path to get an app's image is incorrect")
        XCTAssertTrue(vehicleImagePath.isEqual(to: "https://na-staging-api.moj.io/v2/vehicles/\(vehicleId)/image/"), "The path to get an app's image is incorrect")

    }
    
    func testGroupsPaths () {
        let groupId : NSString = "group-id"
        let groupsPath : NSString = (RestClient().groups(nil)).requestUrl!
        let groupIdPath : NSString = (RestClient().groups("\(groupId)")).requestUrl!
        let groupUsersPath : NSString = (RestClient().groups("\(groupId)").users(nil)).requestUrl!
        
        XCTAssertTrue(groupsPath.isEqual(to: "https://na-staging-api.moj.io/v2/groups/"), "The path to get groups is incorrect")
        XCTAssertTrue(groupIdPath.isEqual(to: "https://na-staging-api.moj.io/v2/groups/\(groupId)/"), "The path to get a group is incorrect")
        XCTAssertTrue(groupUsersPath.isEqual(to: "https://na-staging-api.moj.io/v2/groups/\(groupId)/users/"), "The path to get groups is incorrect")

    }
    
    func testAppsPaths () {
        let appId : NSString = "app-id"
        let appsPath : NSString = (RestClient().apps(nil)).requestUrl!
        let appIdPath : NSString = (RestClient().apps("\(appId)")).requestUrl!
        let appSecretPath : NSString = (RestClient().apps("\(appId)").secret()).requestUrl!
        
        XCTAssertTrue(appsPath.isEqual(to: "https://na-staging-api.moj.io/v2/apps/"), "The path to get the apps is incorrect")
        XCTAssertTrue(appIdPath.isEqual(to: "https://na-staging-api.moj.io/v2/apps/\(appId)/"), "The path to get an app is incorrect")
        XCTAssertTrue(appSecretPath.isEqual(to: "https://na-staging-api.moj.io/v2/apps/\(appId)/secret/"), "The path to get an app's secret is incorrect")

    }
    
    
}
