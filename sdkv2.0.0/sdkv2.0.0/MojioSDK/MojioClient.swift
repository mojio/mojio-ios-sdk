//
//  MojioClient.swift
//  MOJIOSDK
//
//  Created by Ashish Agarwal on 2016-02-08.
//  Copyright © 2016 Ashish. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MojioClient: NSObject {
    
    // this will need a completion block
    class func getEntityWithPath (path : String, params : NSDictionary?) {
        
//        Alamofire.request(.GET, path, parameters : nil,  headers : ["MojioAPIToken" : self.authToken()!]).responseJSON{response in
//            print(response.request);
//            print(response.response);
//        }
        
        Alamofire.request(.GET, path, headers: ["MojioAPIToken" : self.authToken()!]).responseJSON { response in
            
            let json : JSON! = JSON(response.result.value!);
            let data = json["Data"].array;
            
            if data != nil {
                for vehicle in data! {
                    print (vehicle["Id"]);
                }
            }
            
            let error = json["ashsih"];
            
            if error == nil {
                print ("error is nil");
            }
            
            
        }
    }
    
    class private func authToken () -> String? {
        let authToken : String? = NSUserDefaults.standardUserDefaults().objectForKey("MojioAuthToken") as? String;
        return authToken;
    }

}
