//
//  StorageApiTests.swift
//  MojioSDK
//
//  Created by Narayan Sainaney on 2016-05-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import XCTest
import MojioSDK

class StorageApiTests: BaseApiTest {
        
    
    func testUserStorage () {
        
        super.runTest("userStorage"){expectation in
            
            RestClient(clientEnvironment: ClientEnvironment.SharedInstance).get().me()
                .run({response in
                    
                    //expectation.fulfill()

                    
                    if let userId = response.Id {
                        
                        let client = RestClient(clientEnvironment: ClientEnvironment.SharedInstance)
                        client.post().users(userId).storage("testKey").runEncodeJSON( "\"testValue\"", completion: {storageResponse in
                            
                            expectation.fulfill()
                            
                            
                            }, failure: { error in
                                XCTAssertFalse(true, "testUserStorage me:" + error)
                                expectation.fulfill()
                        })
                    }
                                        
                    
                    }, failure: { error in
                        XCTAssertFalse(true, "testUserStorage me:" + error)
                        expectation.fulfill()
                })
        }
    }
}
