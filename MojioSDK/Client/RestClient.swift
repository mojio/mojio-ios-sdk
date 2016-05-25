//
//  RestClient.swift
//  MojioSDK
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

public class RestClientEndpoints : NSObject {
    public static let Apps : String = "apps/"
    public static let Secret : String = "secret/"
    public static let Groups : String = "groups/"
    public static let Users : String = "users/"
    public static let Me : String = "me/"
    public static let History : String = "history/"
    public static let States : String = "states/"
    public static let Locations : String = "locations/"
    public static let Image : String = "image/"
    public static let Mojios : String = "mojios/"
    public static let Permission : String = "permission/"
    public static let Permissions : String = "permissions/"
    public static let Tags : String = "tags/"
    public static let Trips : String = "trips/"
    public static let Vehicles : String = "vehicles/"
    public static let Address : String = "address/"
    public static let Vin : String = "vin/"
    public static let ServiceSchedule : String = "serviceschedule/"
    public static let Next : String = "next/"
}

public class RestClient: NSObject {
    
    private var requestMethod : Alamofire.Method?
    private var baseUrl : String?

    public dynamic var requestUrl : String?
    public dynamic var requestParams : [String:AnyObject] = [:]
    public dynamic var requestEntity : String?
    
    public override init() {
        self.baseUrl = ClientEnvironment.SharedInstance.getApiEndpoint()
        self.requestUrl = self.baseUrl
        
        // Set Auth Token as the header
    }
    
    public convenience init(clientEnvironment : ClientEnvironment) {
        self.init()
        self.baseUrl = clientEnvironment.getApiEndpoint()
        self.requestUrl = self.baseUrl
    }
    
    public func get() -> Self {
        self.requestMethod = Alamofire.Method.GET
        return self
    }
    
    public func post() -> Self {
        self.requestMethod = Alamofire.Method.POST
        return self
    }
    
    public func put() -> Self {
        self.requestMethod = Alamofire.Method.PUT
        return self
    }
    
    public func delete() -> Self {
        self.requestMethod = Alamofire.Method.DELETE
        return self
    }
    
    public func apps(appId : String?) -> Self {
        self.requestEntity = RestClientEndpoints.Apps
        self.requestUrl = self.requestUrl! + self.requestEntity! + (appId != nil ? appId! + "/" : "")
        
        return self
    }
    
    public func secret() -> Self {
        self.requestEntity = RestClientEndpoints.Secret
        self.requestUrl = self.requestUrl! + self.requestEntity!

        return self
    }
    
    public func groups(groupId : String?) -> Self {
        self.requestEntity = RestClientEndpoints.Groups
        self.requestUrl = self.requestUrl! + self.requestEntity! + (groupId != nil ? groupId! + "/" : "")

        return self
    }
    
    public func users(userId : String?) -> Self {
        self.requestEntity = RestClientEndpoints.Users
        self.requestUrl = self.requestUrl! + self.requestEntity! + (userId != nil ? userId! + "/" : "")
        
        return self
    }
    
    public func me() -> Self {
        self.requestEntity = RestClientEndpoints.Me
        self.requestUrl = self.requestUrl! + self.requestEntity!
        
        return self
    }
    
    public func history() -> Self {
        self.requestEntity = RestClientEndpoints.History
        self.requestUrl = self.requestUrl! + self.requestEntity!
        
        return self
    }
    
    public func states() -> Self {
        self.requestEntity = RestClientEndpoints.States
        self.requestUrl = self.requestUrl! + self.requestEntity!
        
        return self
    }
    
    public func locations() -> Self {
        self.requestEntity = RestClientEndpoints.Locations
        self.requestUrl = self.requestUrl! + self.requestEntity!

        return self
    }
    
    public func image() -> Self {
        self.requestEntity = RestClientEndpoints.Image
        self.requestUrl = self.requestUrl! + self.requestEntity!

        return self
    }
    
    public func mojios(mojioId : String?) -> Self {
        self.requestEntity = RestClientEndpoints.Mojios
        self.requestUrl = self.requestUrl! + self.requestEntity! + (mojioId != nil ? mojioId! + "/" : "")

        return self
    }
    
    public func permission() -> Self {
        self.requestEntity = RestClientEndpoints.Permission
        self.requestUrl = self.requestUrl! + self.requestEntity!

        return self
    }
    
    public func permissions() -> Self {
        self.requestEntity = RestClientEndpoints.Permissions
        self.requestUrl = self.requestUrl! + self.requestEntity!

        return self
    }
    
    public func tags(tagId : String) -> Self {
        self.requestEntity = RestClientEndpoints.Tags
        self.requestUrl = self.requestUrl! + self.requestEntity! + tagId + "/"

        return self
    }
    
    public func trips(tripId : String?) -> Self {
        self.requestEntity = RestClientEndpoints.Trips
        self.requestUrl = self.requestUrl! + self.requestEntity! + (tripId != nil ? tripId! + "/" : "")

        return self
    }
    
    public func vehicles(vehicleId : String?) -> Self {
        self.requestEntity = RestClientEndpoints.Vehicles
        self.requestUrl = self.requestUrl! + self.requestEntity! + (vehicleId != nil ? vehicleId! + "/" : "")

        return self
    }
    
    public func address() -> Self {
        self.requestEntity = RestClientEndpoints.Address
        self.requestUrl = self.requestUrl! + self.requestEntity!

        return self
    }
    
    public func vin() -> Self {
        self.requestEntity = RestClientEndpoints.Vin
        self.requestUrl = self.requestUrl! + self.requestEntity!

        return self
    }
    
    public func serviceSchedule() -> Self {
        self.requestEntity = RestClientEndpoints.ServiceSchedule
        self.requestUrl = self.requestUrl! + self.requestEntity!

        return self
    }
    
    public func next() -> Self {
        self.requestEntity = RestClientEndpoints.Next
        self.requestUrl = self.requestUrl! + self.requestEntity!

        return self
    }
    
    public func query(take : NSInteger?, top : String?, skip : String?, filter : String?, select : String?, orderby : String?) -> Self {
        
        var requestParams : [String:AnyObject] = [:]
        
        if take != nil {
            requestParams["take"] = take!
        }
        
        if top != nil {
            requestParams["top"] = top!
        }

        if skip != nil {
            requestParams["skip"] = skip!
        }

        if filter != nil {
            requestParams["filter"] = filter!
        }

        if select != nil {
            requestParams["select"] = select!
        }

        if orderby != nil {
            requestParams["select"] = select!
        }
        
        self.requestUrl = String(self.requestUrl!.characters.dropLast())
        self.requestParams = requestParams
        
        return self
    }
    
    public func run(completion: (response : AnyObject) -> Void, failure: (error : String) -> Void) {
        
        // Before every request, make sure access token exists
        var headers : [String:String] = [:]
        
        if let accessToken : String = self.accessToken() {
            headers["Authorization"] = "Bearer " + accessToken
        }

        Alamofire.request(self.requestMethod!, self.requestUrl!, parameters: self.requestParams, encoding: .URL, headers: headers).responseJSON { response in
            
            if response.response?.statusCode == 200 {
                if let responseDict = response.result.value as? NSDictionary {
                    if let dataArray : NSArray = responseDict.objectForKey("Data") as? NSArray {
                        let array : NSMutableArray = []
                        for  obj in dataArray {
                            array.addObject(self.parseDict(obj as! NSDictionary)!)
                        }
                        
                        completion(response: array)
                    }
                    else {
                        let obj = self.parseDict(responseDict)
                        completion (response: obj!)
                    }
                }
                else {
                    completion(response: true)
                }
            }
            else {
                // print(String.init(data: response.data!, encoding: NSUTF8StringEncoding))
                failure(error: "Could not complete request")
            }
        }        
    }
    
    public func runEncodeJSON(jsonObject: AnyObject, completion: (response : AnyObject) -> Void, failure: (error : String) -> Void) {
        
        // Before every request, make sure access token exists
        var headers : [String:String] = ["Content-Type" : "application/json", "Accept" : "application/json"]
        
        if let accessToken : String = self.accessToken()! {
            headers["Authorization"] = "Bearer " + accessToken
        }
        
        // Pass parameter or customer encoder is n
        let request = Alamofire.request(self.requestMethod!, self.requestUrl!, parameters: [:], encoding: .Custom({(convertible, params) in

            // Add JSON object to body
            let mutableURLRequest = convertible.URLRequest.mutableCopy() as! NSMutableURLRequest
            mutableURLRequest.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(jsonObject, options: NSJSONWritingOptions())
            return (mutableURLRequest, nil)
        }), headers: headers)
        
        print(request.debugDescription)
        
        request.responseJSON(completionHandler: { response in
            
            print(response.debugDescription)
            
            if response.response?.statusCode == 200 {
                if let responseDict = response.result.value as? NSDictionary {
                    if let dataArray : NSArray = responseDict.objectForKey("Data") as? NSArray {
                        let array : NSMutableArray = []
                        for  obj in dataArray {
                            array.addObject(self.parseDict(obj as! NSDictionary)!)
                        }
                        
                        completion(response: array)
                    }
                    else {
                        let obj = self.parseDict(responseDict)
                        completion (response: obj!)
                    }
                }
                else {
                    completion(response: true)
                }
            }
            else {
                // print(String.init(data: response.data!, encoding: NSUTF8StringEncoding))
                failure(error: "Could not complete request")
            }
        })
    }
    
    public func runEncodeUrl(parameters: [String:AnyObject], completion: (response : AnyObject) -> Void, failure: (error : String) -> Void) {
        
        // Before every request, make sure access token exists
        var headers : [String:String] = [:]
        
        if let accessToken : String = self.accessToken()! {
            headers["Authorization"] = "Bearer " + accessToken
        }
        
        Alamofire.request(self.requestMethod!, self.requestUrl!, parameters: parameters, encoding: .URL, headers: headers).responseJSON { response in
            
            if response.response?.statusCode == 200 {
                if let responseDict = response.result.value as? NSDictionary {
                    if let dataArray : NSArray = responseDict.objectForKey("Data") as? NSArray {
                        let array : NSMutableArray = []
                        for  obj in dataArray {
                            array.addObject(self.parseDict(obj as! NSDictionary)!)
                        }
                        
                        completion(response: array)
                    }
                    else {
                        let obj = self.parseDict(responseDict)
                        completion (response: obj!)
                    }
                }
                else {
                    completion(response: true)
                }
            }
            else {
                // print(String.init(data: response.data!, encoding: NSUTF8StringEncoding))
                failure(error: "Could not complete request")
            }
        }
    }
    
    
    public func parseDict(dict : NSDictionary) -> AnyObject? {
        switch self.requestEntity! {
            
        case RestClientEndpoints.Apps:
            let model = Mapper<App>().map(dict)
            return model!
            
        case RestClientEndpoints.Secret:
            return nil
            
        case RestClientEndpoints.Groups:
            let model = Mapper<Group>().map(dict)
            return model!
            
        case RestClientEndpoints.Users:
            let model = Mapper<User>().map(dict)
            return model!
            
        case RestClientEndpoints.Me:
            let model = Mapper<User>().map(dict)
            return model!
            
        case RestClientEndpoints.History:
            return nil
            
        case RestClientEndpoints.States:
            let model = Mapper<VehicleMeasures>().map(dict)
            return model!
            
        case RestClientEndpoints.Locations:
            let model = Mapper<Location>().map(dict)
            return model!

        case RestClientEndpoints.Image:
            let model = Mapper<Image>().map(dict)
            return model!

        case RestClientEndpoints.Mojios:
            let model = Mapper<Mojio>().map(dict)
            return model!
            
        case RestClientEndpoints.Trips:
            let model = Mapper<Trip>().map(dict)
            return model!

        case RestClientEndpoints.Vehicles:
            let model = Mapper<Vehicle>().map(dict)
            return model!
            
        case RestClientEndpoints.Address:
            let model = Mapper<Address>().map(dict)
            return model!
            
        case RestClientEndpoints.Vin:
            let model = Mapper<Vin>().map(dict)
            return model!
            
        case RestClientEndpoints.ServiceSchedule:
            let model = Mapper<ServiceSchedule>().map(dict)
            return model!
            
        case RestClientEndpoints.Next:
            let model = Mapper<NextServiceSchedule>().map(dict)
            return model!

        default:
                return nil
        }
    }
    
    private func accessToken() -> String? {
        return KeychainManager().getAuthToken().accessToken
    }    
}

public extension Object {
    public func toDictionary() -> [String:AnyObject] {
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

public extension ListBase {
    public func toArray() -> [AnyObject] {
        var _toArray = [AnyObject]()
        for i in 0..<self._rlmArray.count {
            let obj = unsafeBitCast(self._rlmArray[i], Object.self)
            _toArray.append(obj.toDictionary())
        }
        return _toArray
    }
}

public extension Dictionary {
    public mutating func update(updateDict: Dictionary) {
        for (key, value) in updateDict {
            self.updateValue(value, forKey:key)
        }
    }
}
