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
import KeychainSwift

open class NextDone {}

open class ClientHeaders: NSObject {
    open static let defaultRequestHeaders: [String:String] = {
        // Accept-Language HTTP Header; see https://tools.ietf.org/html/rfc7231#section-5.3.5
        let acceptLanguage = NSLocale.preferredLanguages.prefix(6).enumerated().map { index, languageCode in
            let quality = 1.0 - (Double(index) * 0.1)
            
            // Use language-region and language only combinations
            let languageSplit = languageCode.components(separatedBy: "-")
            if let language = languageSplit.first {
                return "\(languageCode),\(language);q=\(quality)"
            }
            else if languageSplit.count > 0 {
                return "\(languageCode);q=\(quality)"
            }
            else {
                return ""
            }
            
            }.joined(separator: ", ")
        
        return ["Accept-Language": acceptLanguage]
    }()
}

open class RestClientEndpoints : NSObject {
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
    public static let PhoneNumbers : String = "phonenumbers/"
    public static let Emails : String = "emails/"
    public static let Tags : String = "tags/"
    public static let Trips : String = "trips/"
    public static let Vehicles : String = "vehicles/"
    public static let Address : String = "address/"
    public static let Vin : String = "vin/"
    public static let ServiceSchedule : String = "serviceschedule/"
    public static let Next : String = "next/"
    public static let Activities : String = "activities/"
    public static let NotificationSettings : String = "activities/settings/"
    public static let WifiRadio : String = "wifiradio/"
    public static let Transactions : String = "transactions/"
    public static let Geofences : String = "geofences/"
    public static let Aggregates : String = "aggregates/"
    public static let Statistics : String = "statistics/"
    public static let DiagnosticCodes : String = "diagnosticcodes/"
    public static let Polyline : String = "polyline/"
    
    // Storage
    // Parameters: Type, Id, Key
    // e.g. trips/{id}/store/{key}
    open static let Storage : String = "%@%@/store/%@"
}

open class RestClient: NSObject {
    
    fileprivate var requestMethod : Alamofire.HTTPMethod = .get

    open dynamic var pushUrl : String?
    open dynamic var requestUrl : String?
    open dynamic var requestV1Url : String?
    open dynamic var requestParams : [String:AnyObject] = [:]
    open dynamic var requestEntity : String?
    open dynamic var requestEntityId: String?
    // Default to global concurrent queue with default priority
    open static var defaultDispatchQueue = DispatchQueue.global()
    
    fileprivate dynamic var doNext : Bool = false
    fileprivate dynamic var nextUrl : String? = nil
    fileprivate var sinceBeforeFormatter = DateFormatter()
    fileprivate static let SinceBeforeDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    fileprivate static let SinceBeforeTimezone = TimeZone(abbreviation: "UTC");
    fileprivate var dispatchQueue = RestClient.defaultDispatchQueue
    
    public override init() {
        self.requestUrl = ClientEnvironment.SharedInstance.getApiEndpoint()
        self.requestV1Url = ClientEnvironment.SharedInstance.getV1ApiEndpoint();
        self.pushUrl = ClientEnvironment.SharedInstance.getPushWSEndpoint()

        self.sinceBeforeFormatter.dateFormat = RestClient.SinceBeforeDateFormat
        self.sinceBeforeFormatter.timeZone = RestClient.SinceBeforeTimezone
    }
    
    public convenience init(clientEnvironment : ClientEnvironment) {
        self.init()
        self.requestUrl = clientEnvironment.getApiEndpoint()
        self.requestV1Url = clientEnvironment.getV1ApiEndpoint()
        self.pushUrl = clientEnvironment.getPushWSEndpoint()
    }
    
    open func get() -> Self {
        self.requestMethod = .get
        return self
    }
    
    open func post() -> Self {
        self.requestMethod = .post
        return self
    }
    
    open func put() -> Self {
        self.requestMethod = .put
        return self
    }
    
    open func delete() -> Self {
        self.requestMethod = .delete
        return self
    }
    
    open func continueNext() -> Self {
        self.doNext = true
        return self
    }
    
    private func appendRequestUrlEntityId() {
        if let entityId = self.requestEntityId {
            self.requestUrl = self.requestUrl! + self.requestEntity! + entityId + "/"
        }
        else {
            self.requestUrl = self.requestUrl! + self.requestEntity!
        }
    }
    
    private func appendRequestUrlEntity(entity: String?) {
        if let entity = entity {
            self.requestUrl = self.requestUrl! + entity + "/"
        }
        else {
            self.requestUrl = self.requestUrl!
        }
    }
    
    private func appendPushUrlEntityId() {
        if let entityId = self.requestEntityId {
            self.pushUrl = self.pushUrl! + self.requestEntity! + entityId + "/"
        }
        else {
            self.pushUrl = self.pushUrl! + self.requestEntity!
        }
    }
    
    open func apps(_ appId : String?) -> Self {
        self.requestEntity = RestClientEndpoints.Apps
        self.requestEntityId = appId
        self.appendRequestUrlEntityId()
        
        return self
    }
    
    open func secret() -> Self {
        self.requestEntity = RestClientEndpoints.Secret
        self.requestUrl = self.requestUrl! + self.requestEntity!

        return self
    }
    
    open func groups(_ groupId : String?) -> Self {
        self.requestEntity = RestClientEndpoints.Groups
        self.requestEntityId = groupId
        self.appendRequestUrlEntityId()

        return self
    }
    
    open func users(_ userId : String?) -> Self {
        self.requestEntity = RestClientEndpoints.Users
        self.requestEntityId = userId
        self.appendRequestUrlEntityId()
        self.appendPushUrlEntityId()
        
        return self
    }
    
    open func me() -> Self {
        self.requestEntity = RestClientEndpoints.Me
        self.requestUrl = self.requestUrl! + self.requestEntity!
        
        return self
    }
    
    open func history() -> Self {
        self.requestEntity = RestClientEndpoints.History
        self.requestUrl = self.requestUrl! + self.requestEntity!
        
        return self
    }
    
    open func states(time: Date? = nil) -> Self {
        self.requestEntity = RestClientEndpoints.States
        
        var suffix = ""
        
        if let time = time {
            suffix = self.sinceBeforeFormatter.string(from: time)
        }
        
        self.requestUrl = self.requestUrl! + self.requestEntity! + suffix
        
        return self
    }
    
    open func locations() -> Self {
        self.requestEntity = RestClientEndpoints.Locations
        self.requestUrl = self.requestUrl! + self.requestEntity!

        return self
    }
    
    open func image() -> Self {
        self.requestEntity = RestClientEndpoints.Image
        self.requestUrl = self.requestUrl! + self.requestEntity!

        return self
    }
    
    open func mojios(_ mojioId : String?) -> Self {
        self.requestEntity = RestClientEndpoints.Mojios
        self.requestEntityId = mojioId
        self.appendRequestUrlEntityId()
        self.appendPushUrlEntityId()

        return self
    }
    
    open func phonenumbers (_ phonenumber : String?, sendVerification : Bool?) -> Self {
        self.requestEntity = RestClientEndpoints.PhoneNumbers
        
        var phone : String? = phonenumber
        
        if phone != nil && sendVerification == true {
            phone = phone! + "?sendVerification=true"
        }
        
        self.requestEntityId = phone
        self.appendRequestUrlEntityId()

        return self
    }
    
    open func emails (_ email : String?) -> Self {
        self.requestEntity = RestClientEndpoints.Emails
        self.requestEntityId = email
        self.appendRequestUrlEntityId()
        
        return self
    }
    
    open func permission() -> Self {
        self.requestEntity = RestClientEndpoints.Permission
        self.requestUrl = self.requestUrl! + self.requestEntity!

        return self
    }
    
    open func permissions() -> Self {
        self.requestEntity = RestClientEndpoints.Permissions
        self.requestUrl = self.requestUrl! + self.requestEntity!

        return self
    }
    
    open func tags(_ tagId : String) -> Self {
        self.requestEntity = RestClientEndpoints.Tags
        self.requestUrl = self.requestUrl! + self.requestEntity! + tagId + "/"

        return self
    }
    
    open func trips(_ tripId : String?) -> Self {
        self.requestEntity = RestClientEndpoints.Trips
        self.requestEntityId = tripId
        self.appendRequestUrlEntityId()
        self.appendPushUrlEntityId()

        return self
    }
    
    open func vehicles(_ vehicleId : String?) -> Self {
        self.requestEntity = RestClientEndpoints.Vehicles
        self.requestEntityId = vehicleId
        self.appendRequestUrlEntityId()
        self.appendPushUrlEntityId()

        return self
    }
    
    public func vehicles(_ vehicleId: String, mergeVehicleId: String) -> Self {
        self.requestEntity = RestClientEndpoints.Vehicles
        self.requestEntityId = vehicleId
        self.requestParams["actual"] = mergeVehicleId as AnyObject?
        self.requestUrl = self.requestUrl! + self.requestEntity! + vehicleId + "/"
        self.pushUrl = self.pushUrl! + self.requestEntity! + vehicleId + "/"
        
        return self
    }

    open func notificationSettings() -> Self {
        self.requestEntity = RestClientEndpoints.NotificationSettings
        self.requestUrl = self.requestUrl! + RestClientEndpoints.NotificationSettings
        return self
    }
    
    open func address() -> Self {
        self.requestEntity = RestClientEndpoints.Address
        self.requestUrl = self.requestUrl! + self.requestEntity!

        return self
    }
    
    open func vin() -> Self {
        self.requestEntity = RestClientEndpoints.Vin
        self.requestUrl = self.requestUrl! + self.requestEntity!

        return self
    }
    
    open func serviceSchedule() -> Self {
        self.requestEntity = RestClientEndpoints.ServiceSchedule
        self.requestUrl = self.requestUrl! + self.requestEntity!

        return self
    }
    
    open func next() -> Self {
        self.requestEntity = RestClientEndpoints.Next
        self.requestUrl = self.requestUrl! + self.requestEntity!

        return self
    }
    
    open func storage(_ key: String) -> Self {

        self.requestUrl = self.requestV1Url! + String.init(format: RestClientEndpoints.Storage, self.requestEntity!, self.requestEntityId! , key)
        return self
    }
    
    open func activities() -> Self {
        self.requestEntity = RestClientEndpoints.Activities
        self.requestUrl = self.requestUrl! + self.requestEntity!
        self.pushUrl = self.pushUrl! + self.requestEntity! + "/"
        return self
    }
    
    open func wifiRadio() -> Self {
        self.requestEntity = RestClientEndpoints.WifiRadio
        self.requestUrl = self.requestUrl! + self.requestEntity!
        
        return self
    }
    
    open func transactions(_ transactionId: String?) -> Self {
        self.requestEntity = RestClientEndpoints.Transactions
        self.requestEntityId = transactionId
        self.appendRequestUrlEntityId()
        self.appendPushUrlEntityId()
        
        return self
    }
    
    open func geofences(_ geofenceId: String?) -> Self {
        self.requestEntity = RestClientEndpoints.Geofences
        self.requestEntityId = geofenceId
        self.appendRequestUrlEntityId()
        self.appendPushUrlEntityId()
        
        return self
    }
    
    open func aggregates(ofType type: String?) -> Self {
        
        self.requestEntity = RestClientEndpoints.Aggregates
        self.appendRequestUrlEntity(entity: type)
        
        return self
    }
    
    open func statistics() -> Self {
        self.requestEntity = RestClientEndpoints.Statistics
        self.requestUrl = self.requestUrl! + self.requestEntity!
        
        return self
    }

    open func diagnosticCodes(_ code: String?) -> Self {
        
        self.requestEntity = RestClientEndpoints.DiagnosticCodes
        self.appendRequestUrlEntity(entity: code)
        
        return self
    }
    
    public func polyline() -> Self {
        self.requestEntity = RestClientEndpoints.Polyline
        self.requestUrl = self.requestUrl! + self.requestEntity!
        
        return self
    }

    open func query(top : String? = nil, skip : String? = nil, filter : String? = nil, select : String? = nil, orderby : String? = nil, count : String? = nil, since: Date? = nil, before: Date? = nil, fields: [String]? = nil) -> Self {
        
        var requestParams : [String:AnyObject] = [:]
        
        if let top = top {
            requestParams["top"] = top as AnyObject?
        }

        if let skip = skip {
            requestParams["skip"] = skip as AnyObject?
        }

        if let filter = filter {
            requestParams["filter"] = filter as AnyObject?
        }

        if let select = select {
            requestParams["select"] = select as AnyObject?
        }

        if let orderby = orderby {
            requestParams["orderby"] = orderby as AnyObject?
        }
        
        if let count = count {
            requestParams["includeCount"] = count as AnyObject?
        }
        
        if let date = since {
            requestParams["since"] = self.sinceBeforeFormatter.string(from: date) as AnyObject?
        }

        if let date = before {
            requestParams["before"] = self.sinceBeforeFormatter.string(from: date) as AnyObject?
        }
        
        if let fields = fields , fields.count > 0 {
            requestParams["fields"] = fields.joined(separator: ",") as AnyObject?
        }
        
        
        self.requestParams.update(requestParams)
        return self
    }
    
    public func dispatch(queue: DispatchQueue) {
        self.dispatchQueue = queue
    }
    
    /*
     Don't need this helper function given default values in the other query function
     public func query(top : String?, skip : String?, filter : String?, select : String?, orderby : String?) -> Self {
        return self.query(top, skip : skip, filter : filter, select : select, orderby : orderby, since: nil, before: nil, fields: nil)
    }*/
    
    open func run(completion: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        
        let request = Alamofire.request(self.requestUrl!, method: self.requestMethod, parameters: self.requestParams, encoding: URLEncoding(destination: .methodDependent), headers: self.defaultHeaders).responseJSON { response in
            self.handleResponse(response, completion: completion, failure: failure)
        }
        
        #if DEBUG
            print(request.debugDescription)
        #endif
    }
    
    fileprivate class CustomStringEncoding: ParameterEncoding {
        
        private let customString: String
        
        init(customString: String) {
            self.customString = customString
        }
        
        func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
            var urlRequest = urlRequest.urlRequest
            let quoteEscaped = self.customString.replacingOccurrences(of: "\\\"", with: "\\ \\ \"")
            let quotedString = String.init(format: "\"%@\"", quoteEscaped)
            urlRequest?.httpBody = quotedString.data(using: .utf8, allowLossyConversion: false)
            
            return urlRequest!
        }
    }
    
    fileprivate var defaultHeaders: [String: String] {
        var headers = ClientHeaders.defaultRequestHeaders
        
        headers.update(["Content-Type" : "application/json", "Accept" : "application/json"])
        
        // Before every request, make sure access token exists
        if let accessToken : String = self.accessToken() {
            headers["Authorization"] = "Bearer " + accessToken
        }
        
        return headers
    }
    
    open func runStringBody(string: String, completion: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        
        let request = Alamofire.request(self.requestUrl!, method: self.requestMethod, parameters: [:], encoding: CustomStringEncoding(customString: string), headers: self.defaultHeaders).responseJSON { response in
            self.handleResponse(response, completion: completion, failure: failure)
        }
        
        #if DEBUG
            print(request.debugDescription)
        #endif
    }
    
    open func runEncodeJSON(jsonObject: AnyObject, completion: @escaping (_ response : Any) -> Void, failure: @escaping (_ error : Any?) -> Void) {
        
        let request = Alamofire.request(self.requestUrl!, method: self.requestMethod, parameters: [:], encoding: JSONEncoding.default, headers: self.defaultHeaders).responseJSON { response in
            self.handleResponse(response, completion: completion, failure: failure)
        }

        #if DEBUG
            print(request.debugDescription)
        #endif
    }
    
    open func runEncodeUrl(_ parameters: [String:AnyObject], completion: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        
        // Before every request, make sure access token exists
        var headers : [String:String] = [:]
        
        if let accessToken : String = self.accessToken() {
            headers["Authorization"] = "Bearer " + accessToken
        }
        
        let request = Alamofire.request(self.requestUrl!, method: self.requestMethod, parameters: parameters, encoding: URLEncoding(destination: .methodDependent), headers: headers).responseJSON { response in
            self.handleResponse(response, completion: completion, failure: failure)
        }
        
        #if DEBUG
            debugPrint(request)
        #endif
    }
    
    func handleResponse(_ response: DataResponse<Any>, completion: @escaping (_ response :Any) -> Void, failure: @escaping (_ error: Any?) -> Void){
        if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
            if let responseDict = response.result.value as? [String: Any] {
                if let dataArray = responseDict["Data"] as? [Any] {
                    let array : NSMutableArray = []
                    for  obj in dataArray {
                        if
                            let dict = obj as? [String : Any],
                            let model = self.parseDict(dict) {
                            
                            array.add(model)
                        }
                    }
                    var comp : AnyObject = array
                    if let _ = requestParams["includeCount"] {
                        if let count = responseDict["TotalCount"] as? Int {
                            comp = Result(data: array, count: count)
                        }
                    }
                    
                    completion(comp)

                    if (self.doNext) {
                        if let links = responseDict["Links"] as? [String: Any] {
                            if let next = links["Next"] as? String {
                                // Server sends the same nextUrl sometimes when you've reached the end
                                if let decoded = next.removingPercentEncoding {
                                    if (decoded != self.nextUrl) {
                                        self.nextUrl = decoded
                                        self.requestUrl = decoded
                                        self.requestParams = [:]
                                        self.run(completion: completion, failure:  failure)
                                        return
                                    }
                                }
                            }
                        }
                        completion(NextDone())
                    }
                }
                else {
                    if let obj = self.parseDict(responseDict) {
                        completion (obj)
                    }
                    else {
                        if let message : String = responseDict["Message"] as? String {
                            completion (message)
                        }
                        else {
                            completion ("")
                        }
                    }
                    
                }
            } else if let responseString = response.result.value as? String {
                completion(responseString);
            }
            else {
                completion(true)
            }
        }
        else {
            if let responseDict = response.result.value as? NSDictionary {
                failure (responseDict)
            }
            /*else if let responseError = response.result.error {
                failure (responseError.userInfo)
            }*/
            else {
                failure("Could not complete request")
            }
        }
    }
    
    open func parseDict(_ dict : [String: Any]) -> Any? {
        switch self.requestEntity! {
            
        case RestClientEndpoints.Apps:
            let model = Mapper<App>().map(JSON: dict)
            return model!
            
        case RestClientEndpoints.Secret:
            return nil
            
        case RestClientEndpoints.Groups:
            let model = Mapper<Group>().map(JSON: dict)
            return model!
            
        case RestClientEndpoints.Users:
            let model = Mapper<User>().map(JSON: dict)
            return model!
            
        case RestClientEndpoints.Me:
            let model = Mapper<User>().map(JSON: dict)
            return model!
            
        case RestClientEndpoints.History:
            return nil
            
        case RestClientEndpoints.States:
            let model = Mapper<VehicleMeasures>().map(JSON: dict)
            return model!
            
        case RestClientEndpoints.Locations:
            let model = Mapper<Location>().map(JSON: dict)
            return model!

        case RestClientEndpoints.Image:
            let model = Mapper<Image>().map(JSON: dict)
            return model!

        case RestClientEndpoints.Mojios:
            let model = Mapper<Mojio>().map(JSON: dict)
            return model!
            
        case RestClientEndpoints.Trips:
            let model = Mapper<Trip>().map(JSON: dict)
            return model!

        case RestClientEndpoints.Vehicles:
            let model = Mapper<Vehicle>().map(JSON: dict)
            return model!
            
        case RestClientEndpoints.Address:
            let model = Mapper<Address>().map(JSON: dict)
            return model!
            
        case RestClientEndpoints.Vin:
            let model = Mapper<Vin>().map(JSON: dict)
            return model!
            
        case RestClientEndpoints.ServiceSchedule:
            let model = Mapper<ServiceSchedule>().map(JSON: dict)
            return model!
            
        case RestClientEndpoints.Next:
            let model = Mapper<NextServiceSchedule>().map(JSON: dict)
            return model!

        case RestClientEndpoints.Activities:
            let model = Mapper<RootActivity>().map(JSON: dict)
            return model!
            
        case RestClientEndpoints.NotificationSettings:
            let model = Mapper<NotificationsSettings>().map(JSON: dict)
            return model!
            
        case RestClientEndpoints.WifiRadio:
            // Returns Transaction Id
            return dict["TransactionId"]
            
        case RestClientEndpoints.Transactions:
            // Returns Transaction State
            return dict["State"]
            
        case RestClientEndpoints.Geofences:
            let model = Mapper<Geofence>().map(JSON: dict)
            return model!

        case RestClientEndpoints.Aggregates:
            let model = Mapper<AggregationData>().map(JSON: dict)
            return model!

        case RestClientEndpoints.Statistics:
            let model = Mapper<VehicleStatistics>().map(JSON: dict)
            return model!
            
        case RestClientEndpoints.Polyline:
            let model = Mapper<TripPolyline>().map(JSON: dict)
            return model!
            
        default:
                return nil
        }
    }
    
    func accessToken() -> String? {
        return KeychainManager().getAuthToken().accessToken
    }    
}

public extension Dictionary {
    public mutating func update(_ updateDict: Dictionary) {
        for (key, value) in updateDict {
            self.updateValue(value, forKey:key)
        }
    }
}
/*
internal extension String {
    
    func JSONString() -> String {
        return "\"" + self
            .stringByReplacingOccurrencesOfString("\"", withString: "\\\"", options: .CaseInsensitiveSearch)
            .stringByReplacingOccurrencesOfString("/", withString: "\\/", options: .CaseInsensitiveSearch)
            .stringByReplacingOccurrencesOfString("\n", withString: "\\n", options: .CaseInsensitiveSearch)
            .stringByReplacingOccurrencesOfString("\u{8}", withString: "\\b", options: .CaseInsensitiveSearch)
            .stringByReplacingOccurrencesOfString("\u{12}", withString: "\\f", options: .CaseInsensitiveSearch)
            .stringByReplacingOccurrencesOfString("\r", withString: "\\r", options: .CaseInsensitiveSearch)
            .stringByReplacingOccurrencesOfString("\t", withString: "\\t", options: .CaseInsensitiveSearch) + "\""
    }
}
*/
