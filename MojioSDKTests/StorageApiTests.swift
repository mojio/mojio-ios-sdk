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
            
            let key : String = "testKey"
            let value : String = "testValue"
            // Get Me
            RestClient(clientEnvironment: ClientEnvironment.SharedInstance).get().me()
                .run({response in
                    
                    // Write some data into Me
                    if let userId = response.Id {
                        
                        let client = RestClient(clientEnvironment: ClientEnvironment.SharedInstance)
                        client.post().users(userId).storage(key).runStringBody( value, completion: {storageResponse in
                            
                            RestClient(clientEnvironment: ClientEnvironment.SharedInstance).get().users(userId).storage(key).run({getResponse in
                                
                                if let responseString = getResponse as? String {
                                    XCTAssertEqual(responseString, value)
                                }
                                else {
                                    XCTFail()
                                }

                                expectation.fulfill()
                                
                                }, failure: {error in
                                        XCTFail()
                                        expectation.fulfill()
                                })
                            
                            
                            }, failure: { error in
                                XCTFail()
                                expectation.fulfill()
                        })
                    }
                                        
                    
                    }, failure: { error in
                        XCTFail()
                        expectation.fulfill()
                })
        }
    }
}
