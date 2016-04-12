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

enum MojioApiEndpoints : String {
    case Apps = "apps/"
    case Secret = "secret/"
    case Groups = "groups/"
    case Users = "users/"
    case Me = "me/"
    case History = "history/"
    case States = "states/"
    case Locations = "locations/"
    case Image = "image/"
    case Mojios = "mojios/"
    case Permission = "permission/"
    case Permissions = "permissions/"
    case Tags = "tags/"
    case Trips = "trips/"
    case Vehicles = "vehicles/"
    case Address = "address/"
    case Vin = "vin/"
    case ServiceSchedule = "serviceschedule/"
    case Next = "next/"
}

class MojioClient: NSObject {
    
    static let client = MojioClient()
    
    private var baseUrl : String?
    var requestUrl : String?
    var requestParams : NSDictionary?
    private var requestMethod : Alamofire.Method?
    var requestEntity : MojioApiEndpoints?
    
    override init() {
        self.baseUrl = MojioClientEnvironment.sharedInstance.getApiEndpoint()
        self.requestUrl = self.baseUrl
        
        // Set Auth Token as the header
    }
    
    convenience init(clientEnvironment : MojioClientEnvironment) {
        self.init()
        self.baseUrl = clientEnvironment.getApiEndpoint()
        self.requestUrl = self.baseUrl
    }
    
    func get() -> Self {
        self.requestMethod = Alamofire.Method.GET
        return self
    }
    
    func post() -> Self {
        self.requestMethod = Alamofire.Method.POST
        return self
    }
    
    func put() -> Self {
        self.requestMethod = Alamofire.Method.PUT
        return self
    }
    
    func delete() -> Self {
        self.requestMethod = Alamofire.Method.DELETE
        return self
    }
    
    func apps(appId : String?) -> Self {
        self.requestEntity = MojioApiEndpoints.Apps
        self.requestUrl = self.requestUrl! + (self.requestEntity?.rawValue)! + (appId != nil ? appId! + "/" : "")
        
        return self
    }
    
    func secret() -> Self {
        self.requestEntity = MojioApiEndpoints.Secret
        self.requestUrl = self.requestUrl! + (self.requestEntity?.rawValue)!

        return self
    }
    
    func groups(groupId : String?) -> Self {
        self.requestEntity = MojioApiEndpoints.Groups
        self.requestUrl = self.requestUrl! + (self.requestEntity?.rawValue)! + (groupId != nil ? groupId! + "/" : "")

        return self
    }
    
    func users(userId : String?) -> Self {
        self.requestEntity = MojioApiEndpoints.Users
        self.requestUrl = self.requestUrl! + (self.requestEntity?.rawValue)! + (userId != nil ? userId! + "/" : "")
        
        return self
    }
    
    func me() -> Self {
        self.requestEntity = MojioApiEndpoints.Me
        self.requestUrl = self.requestUrl! + (self.requestEntity?.rawValue)!
        
        return self
    }
    
    func history() -> Self {
        self.requestEntity = MojioApiEndpoints.History
        self.requestUrl = self.requestUrl! + (self.requestEntity?.rawValue)!
        
        return self
    }
    
    func states() -> Self {
        self.requestEntity = MojioApiEndpoints.States
        self.requestUrl = self.requestUrl! + (self.requestEntity?.rawValue)!
        
        return self
    }
    
    func locations() -> Self {
        self.requestEntity = MojioApiEndpoints.Locations
        self.requestUrl = self.requestUrl! + (self.requestEntity?.rawValue)!

        return self
    }
    
    func image() -> Self {
        self.requestEntity = MojioApiEndpoints.Image
        self.requestUrl = self.requestUrl! + (self.requestEntity?.rawValue)!

        return self
    }
    
    func mojios(mojioId : String?) -> Self {
        self.requestEntity = MojioApiEndpoints.Mojios
        self.requestUrl = self.requestUrl! + (self.requestEntity?.rawValue)! + (mojioId != nil ? mojioId! + "/" : "")

        return self
    }
    
    func permission() -> Self {
        self.requestEntity = MojioApiEndpoints.Permission
        self.requestUrl = self.requestUrl! + (self.requestEntity?.rawValue)!

        return self
    }
    
    func permissions() -> Self {
        self.requestEntity = MojioApiEndpoints.Permissions
        self.requestUrl = self.requestUrl! + (self.requestEntity?.rawValue)!

        return self
    }
    
    func tags(tagId : String) -> Self {
        self.requestEntity = MojioApiEndpoints.Tags
        self.requestUrl = self.requestUrl! + (self.requestEntity?.rawValue)! + tagId + "/"

        return self
    }
    
    func trips(tripId : String?) -> Self {
        self.requestEntity = MojioApiEndpoints.Trips
        self.requestUrl = self.requestUrl! + (self.requestEntity?.rawValue)! + (tripId != nil ? tripId! + "/" : "")

        return self
    }
    
    func vehicles(vehicleId : String?) -> Self {
        self.requestEntity = MojioApiEndpoints.Vehicles
        self.requestUrl = self.requestUrl! + (self.requestEntity?.rawValue)! + (vehicleId != nil ? vehicleId! + "/" : "")

        return self
    }
    
    func address() -> Self {
        self.requestEntity = MojioApiEndpoints.Address
        self.requestUrl = self.requestUrl! + (self.requestEntity?.rawValue)!

        return self
    }
    
    func vin() -> Self {
        self.requestEntity = MojioApiEndpoints.Vin
        self.requestUrl = self.requestUrl! + (self.requestEntity?.rawValue)!

        return self
    }
    
    func serviceSchedule() -> Self {
        self.requestEntity = MojioApiEndpoints.ServiceSchedule
        self.requestUrl = self.requestUrl! + (self.requestEntity?.rawValue)!

        return self
    }
    
    func next() -> Self {
        self.requestEntity = MojioApiEndpoints.Next
        self.requestUrl = self.requestUrl! + (self.requestEntity?.rawValue)!

        return self
    }
    
    func query(top : String?, skip : String?, filter : String?, select : String?, orderby : String?) -> Self {
        
        let requestParams : NSMutableDictionary = NSMutableDictionary()
        
        if top != nil {
            requestParams.setObject(top!, forKey: "$top")
        }
        if skip != nil {
            requestParams.setObject(skip!, forKey: "$skip")
        }
        if filter != nil {
            requestParams.setObject(filter!, forKey: "$filter")
        }
        if select != nil {
            requestParams.setObject(select!, forKey: "$select")
        }
        if orderby != nil {
            requestParams.setObject(orderby!, forKey: "$orderby")
        }
        
        self.requestParams = requestParams
        return self
    }
    
    
    func run(body : NSString?, completion : (response : AnyObject) -> Void, failure : (error : String) -> Void) {
        
        // Before every request, make sure access token exists
        let authToken = self.authToken() != nil ? self.authToken()! : ""

        if self.requestMethod! == Alamofire.Method.PUT || self.requestMethod! == Alamofire.Method.POST {
            
            Alamofire.request(self.requestMethod!, self.requestUrl!, parameters: [:], encoding: .Custom({
                (convertible, params) in
                let mutableRequest : NSMutableURLRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
                mutableRequest.setValue("Bearer " + authToken, forHTTPHeaderField: "Authorization")
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
    
    func run(completion : (response : AnyObject) -> Void, failure : (error : String) -> Void){
        
        // Before every request, make sure access token exists
        let authToken = self.authToken() != nil ? self.authToken()! : ""

        Alamofire.request(self.requestMethod!, self.requestUrl!, parameters : self.requestParams as? [String : AnyObject], headers : ["Authorization" : "Bearer " + authToken]).responseJSON { response in
            
            if response.response != nil && response.response?.statusCode == 200 {
                
                if self.requestMethod! == Alamofire.Method.GET {
                    let responseDict = response.result.value as? NSDictionary
                    if responseDict != nil {
                        let dataArray = responseDict?.objectForKey("Data") as? NSArray
                        if dataArray == nil {
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
                    
                else if self.requestMethod! == Alamofire.Method.DELETE {
                    completion (response: true)
                }
                
            }
            else {
                failure(error: "Could not complete request")
            }
        }        
    }
    
    
    func parseDict(dict : NSDictionary) -> AnyObject? {
        switch self.requestEntity! {
            
        case MojioApiEndpoints.Apps:
            let model = Mapper<App>().map(dict)
            return model!
            
        case MojioApiEndpoints.Secret:
            return nil
            
        case MojioApiEndpoints.Groups:
            let model = Mapper<Group>().map(dict)
            return model!
            
        case MojioApiEndpoints.Users:
            let model = Mapper<User>().map(dict)
            return model!
            
        case MojioApiEndpoints.Me:
            let model = Mapper<User>().map(dict)
            return model!
            
        case MojioApiEndpoints.History:
            return nil
            
        case MojioApiEndpoints.States:
            let model = Mapper<VehicleMeasures>().map(dict)
            return model!
            
        case MojioApiEndpoints.Locations:
            let model = Mapper<Location>().map(dict)
            return model!

        case MojioApiEndpoints.Image:
            let model = Mapper<Image>().map(dict)
            return model!

        case MojioApiEndpoints.Mojios:
            let model = Mapper<Mojio>().map(dict)
            return model!
            
        case MojioApiEndpoints.Trips:
            let model = Mapper<Trip>().map(dict)
            return model!

        case MojioApiEndpoints.Vehicles:
            let model = Mapper<Vehicle>().map(dict)
            return model!
            
        case MojioApiEndpoints.Address:
            let model = Mapper<Address>().map(dict)
            return model!
            
        case MojioApiEndpoints.Vin:
            let model = Mapper<Vin>().map(dict)
            return model!
            
        case MojioApiEndpoints.ServiceSchedule:
            let model = Mapper<ServiceSchedule>().map(dict)
            return model!
            
        case MojioApiEndpoints.Next:
            let model = Mapper<NextServiceSchedule>().map(dict)
            return model!

        default:
                return nil
        }
    }
    
    private func authToken () -> String? {
        
        let token = MojioKeychainManager().getAuthToken()
        let authToken = token.0
        
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
