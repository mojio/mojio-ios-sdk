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
import KeychainSwift

class MojioClient: NSObject {
    
    static let client = MojioClient()
    
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
    
    var REQUEST_URL : String
    private var REST_METHOD : Alamofire.Method?
    var ENTITY_REQUESTED : String = ""
    
    override init () {
        self.REQUEST_URL = MojioClientEnvironment.clientEnvironment.getApiEndpoint()
        // set auth token as the header 
    }
    
    func get () -> Self {
        self.REST_METHOD = Method.GET
        return self
    }
    
    func post () -> Self {
        self.REST_METHOD = Method.POST
        return self
    }
    
    func put () -> Self {
        self.REST_METHOD = Method.PUT
        return self
    }
    
    func delete () -> Self {
        self.REST_METHOD = Method.DELETE
        return self
    }
    
    func apps (appId : String?) -> Self {
        if appId != nil {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_APPS + appId! + "/"
        }
        else {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_APPS
        }
        self.ENTITY_REQUESTED = PATH_APPS
        return self
    }
    
    func secret () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_SECRET
        self.ENTITY_REQUESTED = PATH_SECRET
        return self
    }
    
    func groups (groupId : String?) -> Self {
        if (groupId != nil) {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_GROUPS + groupId! + "/"
        }
        else {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_GROUPS
        }
        self.ENTITY_REQUESTED = PATH_GROUPS
        return self
    }
    
    func users (userId : String?) -> Self {
        if userId != nil {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_USERS + userId! + "/"
        }
        else {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_USERS
        }
        self.ENTITY_REQUESTED = PATH_USERS
        return self
    }
    
    func me () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_ME
        self.ENTITY_REQUESTED = PATH_ME
        return self
    }
    
    func history () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_HISTORY
        self.ENTITY_REQUESTED = PATH_HISTORY
        return self
    }
    
    func states () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_STATES
        self.ENTITY_REQUESTED = PATH_STATES
        return self
    }
    
    func locations () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_LOCATIONS
        self.ENTITY_REQUESTED = PATH_LOCATIONS
        return self
    }
    
    func image () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_IMAGE
        self.ENTITY_REQUESTED = PATH_IMAGE
        return self
    }
    
    func mojios (mojioId : String?) -> Self {
        if mojioId != nil {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_MOJIOS + mojioId! + "/"
        }
        else {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_MOJIOS
        }
        self.ENTITY_REQUESTED = PATH_MOJIOS
        return self
    }
    
    func permission () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_PERMISSION
        self.ENTITY_REQUESTED = PATH_PERMISSION
        return self
    }
    
    func permissions () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_PERMISSIONS
        self.ENTITY_REQUESTED = PATH_PERMISSIONS
        return self
    }
    
    func tags (tagId : String) -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_TAGS + tagId + "/"
        self.ENTITY_REQUESTED = PATH_TAGS
        return self
    }
    
    func trips (tripId : String?) -> Self {
        if tripId != nil {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_TRIPS + tripId! + "/"
        }
        else {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_TRIPS
        }
        self.ENTITY_REQUESTED = PATH_TRIPS
        return self
    }
    
    func vehicles (vehicleId : String?) -> Self {
        if vehicleId != nil {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_VEHICLES + vehicleId! + "/"
        }
        else {
            self.REQUEST_URL = self.REQUEST_URL + self.PATH_VEHICLES
        }
        self.ENTITY_REQUESTED = PATH_VEHICLES
        return self
    }
    
    func address () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_ADDRESS
        self.ENTITY_REQUESTED = PATH_ADDRESS
        return self
    }
    
    func vin () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_VIN
        self.ENTITY_REQUESTED = PATH_VIN
        return self
    }
    
    func serviceschedule () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_SERVICE_SCHEDULE
        self.ENTITY_REQUESTED = PATH_SERVICE_SCHEDULE
        return self
    }
    
    func next () -> Self {
        self.REQUEST_URL = self.REQUEST_URL + self.PATH_NEXT
        self.ENTITY_REQUESTED = PATH_NEXT
        return self
    }
    
    func run (body : NSString?, completion : (response : AnyObject) -> Void, failure : (error : String) -> Void) {
        // before every request, make sure user is logged in
        let authToken = self.authToken() != nil ? self.authToken()! : ""

        if self.REST_METHOD! == Alamofire.Method.PUT || self.REST_METHOD! == Alamofire.Method.POST {
            
            Alamofire.request(self.REST_METHOD!, self.REQUEST_URL, parameters: [:], encoding: .Custom({
                (convertible, params) in
                let mutableRequest : NSMutableURLRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
                mutableRequest.setValue(authToken, forHTTPHeaderField: "MojioAPIToken")
                mutableRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                mutableRequest.HTTPBody = body?.dataUsingEncoding(NSUTF8StringEncoding)
                return (mutableRequest, nil)
            })).responseJSON{ response in
                if response.response?.statusCode == 200 {
                    completion (response: true)
                }
                else {
                    completion (response: false)
                }
            }
        }
    }
    
    func run (completion : (response : AnyObject) -> Void, failure : (error : String) -> Void){
        // before every request, make sure user is logged in
        
        let authToken = self.authToken() != nil ? self.authToken()! : ""
        
        Alamofire.request(self.REST_METHOD!, self.REQUEST_URL, headers : ["MojioAPIToken" : authToken]).responseJSON { response in
            
            if response.response != nil && response.response?.statusCode == 200 {
                
                if self.REST_METHOD! == Alamofire.Method.GET {
                    let responseDict = response.result.value as? NSDictionary
                    if responseDict != nil {
                        let dataArray = responseDict?.objectForKey("Data") as? NSArray
                        if dataArray == nil {
                            print ("we have a dictionary")
                            let obj = self.parseDict(responseDict!)
                            completion (response: obj!)
                        }
                            
                        else {
                            let array : NSMutableArray = []
                            for  obj in dataArray! {
                                array.addObject(self.parseDict(obj as! NSDictionary)!)
                            }
                            
                            completion(response: array)
                            
                        }
                    }
                }
                    
                else if self.REST_METHOD! == Alamofire.Method.DELETE {
                    completion (response: true)
                }
                
            }
            else {
                failure(error: "Could not complete request")
            }
        }
        
    }
    
    func parseDict (dict : NSDictionary) -> AnyObject? {
        switch self.ENTITY_REQUESTED{
            
        case self.PATH_APPS:
            let model = Mapper<App>().map(dict)
            return model!
            
        case self.PATH_SECRET:
            return nil
            
        case self.PATH_GROUPS:
            let model = Mapper<Group>().map(dict)
            return model!
            
        case self.PATH_USERS:
            let model = Mapper<User>().map(dict)
            return model!
            
        case self.PATH_ME:
            let model = Mapper<User>().map(dict)
            return model!
            
        case self.PATH_HISTORY:
            return nil
            
        case self.PATH_STATES:
            let model = Mapper<VehicleMeasures>().map(dict)
            return model!
            
        case self.PATH_LOCATIONS:
            let model = Mapper<Location>().map(dict)
            return model!

        case self.PATH_IMAGE:
            let model = Mapper<Image>().map(dict)
            return model!

        case self.PATH_MOJIOS:
            let model = Mapper<Mojio>().map(dict)
            return model!
            
        case self.PATH_TRIPS:
            let model = Mapper<Trip>().map(dict)
            return model!

        case self.PATH_VEHICLES:
            let model = Mapper<Vehicle>().map(dict)
            return model!
            
        case self.PATH_ADDRESS:
            let model = Mapper<Address>().map(dict)
            return model!
            
        case self.PATH_VIN:
            let model = Mapper<Vin>().map(dict)
            return model!
            
        case self.PATH_SERVICE_SCHEDULE:
            let model = Mapper<ServiceSchedule>().map(dict)
            return model!
            
        case self.PATH_NEXT:
            let model = Mapper<NextServiceSchedule>().map(dict)
            return model!

        default:
                return nil
        }
    }
    
    private func authToken () -> String? {
        let keychain = KeychainSwift()
        let authToken : String? = keychain.get("MojioAuthToken")
        return authToken
    }
    
}

extension Object {
    func toDictionary() -> [String:AnyObject] {
        let properties = self.objectSchema.properties.map { $0.name }
        var dicProps = [String:AnyObject]()
        for (key, value) in self.dictionaryWithValuesForKeys(properties) {
            if let value = value as? ListBase {
                dicProps[key] = value.toArray()
            } else if let value = value as? Object {
                dicProps[key] = value.toDictionary()
            } else {
                dicProps[key] = value
            }
        }
        return dicProps
    }
}

extension ListBase {
    func toArray() -> [AnyObject] {
        var _toArray = [AnyObject]()
        for i in 0..<self._rlmArray.count {
            let obj = unsafeBitCast(self._rlmArray[i], Object.self)
            _toArray.append(obj.toDictionary())
        }
        return _toArray
    }
}
