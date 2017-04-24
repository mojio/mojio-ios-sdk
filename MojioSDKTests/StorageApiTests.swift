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
