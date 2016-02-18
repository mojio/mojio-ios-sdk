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
import ObjectMapper
import RealmSwift


class MojioClient: NSObject {
    
    static let baseUrlString : String = "https://staging-api.moj.io/v2/";
    
    // this will need a completion block
    class func getEntityWithPath (var path : String, params : NSDictionary?) {
        
//        let entityType : String? = path.componentsSeparatedByString("/")[0];
        
        path = self.baseUrlString + path;
        let authToken = self.authToken()!;
        Alamofire.request(.GET, path, headers: ["MojioAPIToken" : authToken]).responseJSON { response in
            
            let dict : NSDictionary? = response.result.value as? NSDictionary
            
            let test = Mapper<Trip>().map(dict!)
            let realm = try! Realm()

            
            try! realm.write({ () -> Void in
                realm.add(test!)
            })

            
            let alltrips : Results<Trip> = realm.objects(Trip)
//            print (alltrips)
            let firstTrip = alltrips[0]
            print (firstTrip)

//            let id : String = (firstTrip?.Id)!
//            let odo = firstTrip?.StartOdometer
//            let location = (firstTrip?.StartLocation)!
//            
//            print (location)
            
            
//            let tripa = alltrips.first
            
            
            print ("test is %@", test);
            
            
        }
    }
    
    
    
    class private func authToken () -> String? {
        let authToken : String? = NSUserDefaults.standardUserDefaults().objectForKey("MojioAuthToken") as? String;
        return authToken;
    }

}
