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

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper
import KeychainSwift

open class NextDone {}

open class ClientHeaders {
    private let languages: [String]
    private let languageWeights = [1.0, 0.9, 0.8, 0.7, 0.6, 0.5]
    
    public init(languages: [String] = NSLocale.preferredLanguages) {
        self.languages = languages
    }
    open var defaultRequestHeaders: [String: String] {
        // Accept-Language HTTP Header; see https://tools.ietf.org/html/rfc7231#section-5.3.5
        let acceptLanguage = self.languages
            .prefix(self.languageWeights.count)
            .enumerated()
            .map { (arg) -> String in
                let (index, language) = arg
                if index == 0 {
                    return language
                } else {
                    return "\(language);q=\(languageWeights[index])"
                }
            }
            .joined(separator: ", ")
        
        return ["Accept-Language": languages.count > 0 ? acceptLanguage : "en"]
    }
}

public enum RestClientEndpoint: String {
    case base = "/"
    case apps = "apps/"
    case secret = "secret/"
    case groups = "groups/"
    case users = "users/"
    case me = "me/"
    case history = "history/"
    case locations = "locations/"
    case mojios = "mojios/"
    case permission = "permission/"
    case permissions = "permissions/"
    case phoneNumbers = "phonenumbers/"
    case emails = "emails/"
    case tags = "tags/"
    case trips = "trips/"
    case vehicles = "vehicles/"
    case address = "address/"
    case vin = "vin/"
    case serviceSchedule = "serviceschedule/"
    case next = "next/"
    case activities = "activities/"
    case notificationSettings = "activities/settings/"
    case wifiRadio = "wifiradio/"
    case transactions = "transactions/"
    case geofences = "geofences/"
    case aggregates = "aggregates/"
    case statistics = "statistics/"
    case diagnosticCodes = "diagnosticcodes/"
    case polyline = "polyline/"
    
    // Storage
    // Parameters: Type, Id, Key
    // e.g. trips/{id}/store/{key}
    case storage = "%@%@/store/%@"
}

open class RestClient {
    
    fileprivate var requestMethod: Alamofire.HTTPMethod = .get

    open var pushUrl: String?
    open var requestUrl: String?
    open var requestV1Url: String?
    open var requestParams: [String:AnyObject] = [:]
    open var requestEntity: RestClientEndpoint = .base
    open var requestEntityId: String?
    // Default to global concurrent queue with default priority
    open static var defaultDispatchQueue = DispatchQueue.global()
    
    fileprivate var doNext: Bool = false
    fileprivate var nextUrl: String? = nil
    fileprivate var sinceBeforeFormatter = DateFormatter()
    fileprivate static let SinceBeforeDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    fileprivate static let SinceBeforeTimezone = TimeZone(abbreviation: "UTC");
    fileprivate var dispatchQueue = RestClient.defaultDispatchQueue
    
    internal let sessionManager: SessionManager
    private var keychainManager: KeychainManager

    public init(clientEnvironment: ClientEnvironment, sessionManager: SessionManager = SessionManager.default, keychainManager: KeychainManager = KeychainManager()) {
        self.requestUrl = clientEnvironment.getApiEndpoint()
        self.requestV1Url = clientEnvironment.getV1ApiEndpoint()
        self.pushUrl = clientEnvironment.getPushWSEndpoint()
        self.sessionManager = sessionManager
        self.keychainManager = keychainManager

        
        self.initDateFormatters()
    }
    
    private func initDateFormatters() {
        self.sinceBeforeFormatter.dateFormat = RestClient.SinceBeforeDateFormat
        self.sinceBeforeFormatter.timeZone = RestClient.SinceBeforeTimezone
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
    
    fileprivate func appendRequestUrlEntityId(asFinal: Bool = false) {
        if let entityId = self.requestEntityId {
            self.requestUrl = self.requestUrl! + self.requestEntity.rawValue + entityId + (asFinal ? "" : "/")
        }
        else {
            self.requestUrl = self.requestUrl! + self.requestEntity.rawValue
        }
    }
    
    fileprivate func appendRequestUrlEntity(_ entity: String?, asFinal: Bool = false) {
        if let entity = entity {
            self.requestUrl = self.requestUrl! + entity + (asFinal ? "" : "/")
        }
        else {
            self.requestUrl = self.requestUrl!
        }
    }
    
    fileprivate func appendPushUrlEntityId(asFinal: Bool = false) {
        if let entityId = self.requestEntityId {
            self.pushUrl = self.pushUrl! + self.requestEntity.rawValue + entityId + (asFinal ? "" : "/")
        }
        else {
            self.pushUrl = self.pushUrl! + self.requestEntity.rawValue
        }
    }
    
    open func apps(_ appId: String? = nil) -> Self {
        self.requestEntity = .apps
        self.requestEntityId = appId
        self.appendRequestUrlEntityId()
        
        return self
    }
    
    open func secret() -> Self {
        self.requestEntity = .secret
        self.requestUrl = self.requestUrl! + self.requestEntity.rawValue

        return self
    }
    
    open func groups(_ groupId: String? = nil) -> Self {
        self.requestEntity = .groups
        self.requestEntityId = groupId
        self.appendRequestUrlEntityId()

        return self
    }
    
    open func users(_ userId: String? = nil) -> Self {
        self.requestEntity = .users
        self.requestEntityId = userId
        self.appendRequestUrlEntityId()
        self.appendPushUrlEntityId()
        
        return self
    }
    
    open func me() -> Self {
        self.requestEntity = .me
        self.requestUrl = self.requestUrl! + self.requestEntity.rawValue
        
        return self
    }
    
    open func history() -> Self {
        self.requestEntity = .history
        self.requestUrl = self.requestUrl! + self.requestEntity.rawValue
        
        return self
    }
    
    open func locations() -> Self {
        self.requestEntity = .locations
        self.requestUrl = self.requestUrl! + self.requestEntity.rawValue
        
        return self
    }
    
    open func mojios(_ mojioId: String? = nil) -> Self {
        self.requestEntity = .mojios
        self.requestEntityId = mojioId
        self.appendRequestUrlEntityId()
        self.appendPushUrlEntityId()

        return self
    }
    
    open func phonenumbers(_ phonenumber: String? = nil, sendVerification: Bool = false) -> Self {
        self.requestEntity = .phoneNumbers
        self.requestEntityId = phonenumber.flatMap { $0 + (sendVerification ? "?sendVerification=true" : "") }
        self.appendRequestUrlEntityId(asFinal: true)

        return self
    }
    
    open func emails (_ email: String? = nil) -> Self {
        self.requestEntity = .emails
        self.requestEntityId = email
        self.appendRequestUrlEntityId()
        
        return self
    }
    
    open func permission() -> Self {
        self.requestEntity = .permission
        self.requestUrl = self.requestUrl! + self.requestEntity.rawValue

        return self
    }
    
    open func permissions() -> Self {
        self.requestEntity = .permissions
        self.requestUrl = self.requestUrl! + self.requestEntity.rawValue

        return self
    }
    
    open func tags(_ tagId: String) -> Self {
        self.requestEntity = .tags
        self.requestUrl = self.requestUrl! + self.requestEntity.rawValue + tagId + "/"

        return self
    }
    
    open func trips(_ tripId: String? = nil) -> Self {
        self.requestEntity = .trips
        self.requestEntityId = tripId
        self.appendRequestUrlEntityId()
        self.appendPushUrlEntityId()

        return self
    }
    
    open func vehicles(_ vehicleId: String? = nil) -> Self {
        self.requestEntity = .vehicles
        self.requestEntityId = vehicleId
        self.appendRequestUrlEntityId()
        self.appendPushUrlEntityId()

        return self
    }
    
    public func vehicles(_ vehicleId: String, mergeVehicleId: String) -> Self {
        self.requestEntity = .vehicles
        self.requestEntityId = vehicleId
        self.requestParams["actual"] = mergeVehicleId as AnyObject?
        self.requestUrl = self.requestUrl! + self.requestEntity.rawValue + vehicleId + "/"
        self.pushUrl = self.pushUrl! + self.requestEntity.rawValue + vehicleId + "/"
        
        return self
    }

    open func notificationSettings() -> Self {
        self.requestEntity = .notificationSettings
        self.requestUrl = self.requestUrl! + self.requestEntity.rawValue
        return self
    }
    
    open func address() -> Self {
        self.requestEntity = .address
        self.requestUrl = self.requestUrl! + self.requestEntity.rawValue

        return self
    }
    
    open func vin() -> Self {
        self.requestEntity = .vin
        self.requestUrl = self.requestUrl! + self.requestEntity.rawValue

        return self
    }
    
    open func serviceSchedule() -> Self {
        self.requestEntity = .serviceSchedule
        self.requestUrl = self.requestUrl! + self.requestEntity.rawValue

        return self
    }
    
    open func next() -> Self {
        self.requestEntity = .next
        self.requestUrl = self.requestUrl! + self.requestEntity.rawValue

        return self
    }
    
    open func storage(_ key: String) -> Self {

        if let requestEntityId = self.requestEntityId {
            self.requestUrl = self.requestV1Url! + String(format: RestClientEndpoint.storage.rawValue, self.requestEntity.rawValue, requestEntityId, key)
        }

        return self
    }
    
    open func activities() -> Self {
        self.requestEntity = .activities
        self.requestUrl = self.requestUrl! + self.requestEntity.rawValue
        self.pushUrl = self.pushUrl! + self.requestEntity.rawValue
        return self
    }
    
    open func wifiRadio() -> Self {
        self.requestEntity = .wifiRadio
        self.requestUrl = self.requestUrl! + self.requestEntity.rawValue
        
        return self
    }
    
    open func transactions(_ transactionId: String? = nil) -> Self {
        self.requestEntity = .transactions
        self.requestEntityId = transactionId
        self.appendRequestUrlEntityId()
        self.appendPushUrlEntityId()
        
        return self
    }
    
    open func geofences(_ geofenceId: String? = nil) -> Self {
        self.requestEntity = .geofences
        self.requestEntityId = geofenceId
        self.appendRequestUrlEntityId()
        self.appendPushUrlEntityId()
        
        return self
    }
    
    open func aggregates(ofType type: String? = nil) -> Self {
        
        self.requestEntity = .aggregates
        self.appendRequestUrlEntity(self.requestEntity.rawValue, asFinal: true)
        self.appendRequestUrlEntity(type)
        
        return self
    }
    
    open func statistics() -> Self {
        self.requestEntity = .statistics
        self.requestUrl = self.requestUrl! + self.requestEntity.rawValue
        
        return self
    }

    open func diagnosticCodes(_ code: String? = nil) -> Self {
        
        self.requestEntity = .diagnosticCodes
        self.appendRequestUrlEntity(self.requestEntity.rawValue, asFinal: true)
        self.appendRequestUrlEntity(code, asFinal: true)
        
        return self
    }
    
    public func polyline() -> Self {
        self.requestEntity = .polyline
        self.requestUrl = self.requestUrl! + self.requestEntity.rawValue
        
        return self
    }

    open func query(top: String? = nil, skip: String? = nil, filter: String? = nil, select: String? = nil, orderby: String? = nil, count: String? = nil, since: Date? = nil, before: Date? = nil, fields: [String]? = nil) -> Self {
        
        var requestParams: [String:AnyObject] = [:]
        
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
     public func query(top: String?, skip: String?, filter: String?, select: String?, orderby: String?) -> Self {
        return self.query(top, skip: skip, filter: filter, select: select, orderby: orderby, since: nil, before: nil, fields: nil)
    }*/
    
    open func run(completion: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        
        let request = self.sessionManager.request(self.requestUrl!, method: self.requestMethod, parameters: self.requestParams, encoding: URLEncoding(destination: .methodDependent), headers: self.defaultHeaders).responseJSON(queue: self.dispatchQueue, options: .allowFragments) {response in
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
            urlRequest?.httpBody = self.customString.asJSONEncodedString().data(using: .utf8, allowLossyConversion: false)
            
            return urlRequest!
        }
    }
    
    fileprivate var defaultHeaders: [String: String] {
        var headers = ClientHeaders().defaultRequestHeaders
        
        headers.update(["Content-Type": "application/json", "Accept": "application/json"])
        
        // Before every request, make sure access token exists
        if let accessToken: String = self.accessToken() {
            headers["Authorization"] = "Bearer " + accessToken
        }
        
        return headers
    }
    
    open func runStringBody(string: String, completion: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        
        let request = self.sessionManager.request(self.requestUrl!, method: self.requestMethod, parameters: [:], encoding: CustomStringEncoding(customString: string), headers: self.defaultHeaders).responseJSON(queue: self.dispatchQueue, options: .allowFragments) {response in
            self.handleResponse(response, completion: completion, failure: failure)
        }
        
        #if DEBUG
            print(request.debugDescription)
        #endif
    }
    
    open func runEncodeJSON(jsonObject: [String: Any], completion: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        
        let request = self.sessionManager.request(self.requestUrl!, method: self.requestMethod, parameters: jsonObject, encoding: JSONEncoding.default, headers: self.defaultHeaders).responseJSON(queue: self.dispatchQueue, options: .allowFragments) {response in
            self.handleResponse(response, completion: completion, failure: failure)
        }

        #if DEBUG
            print(request.debugDescription)
        #endif
    }
    
    open func runEncodeUrl(_ parameters: [String: Any], completion: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        
        // Before every request, make sure access token exists
        var headers: [String:String] = [:]
        
        if let accessToken: String = self.accessToken() {
            headers["Authorization"] = "Bearer " + accessToken
        }
        
        let request = self.sessionManager.request(self.requestUrl!, method: self.requestMethod, parameters: parameters, encoding: URLEncoding(destination: .methodDependent), headers: headers).responseJSON(queue: self.dispatchQueue, options: .allowFragments) {response in
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
                    
                    var array = [Any]()
                    
                    for obj in dataArray {
                        if
                            let dict = obj as? [String: Any],
                            let model = self.parseDict(dict) {
                            
                            array.append(model)
                        }
                    }
                    
                    if
                        let _ = requestParams["includeCount"],
                        let count = responseDict["TotalCount"] as? Int {
                        
                        completion(Result(TotalCount: count, Data: array))
                    } else {
                        completion(array)
                    }

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
                        if let message: String = responseDict["Message"] as? String {
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
    
    open func parseDict(_ dict: [String: Any]) -> Any? {
        switch self.requestEntity {
            
        case .apps:
            return Mapper<App>().map(JSON: dict)
            
        case .secret:
            return nil
            
        case .groups:
            return Mapper<Group>().map(JSON: dict)
            
        case .users:
            return Mapper<User>().map(JSON: dict)
            
        case .me:
            return Mapper<User>().map(JSON: dict)
            
        case .history:
            return nil
            
        case .locations:
            return Mapper<Location>().map(JSON: dict)

        case .mojios:
            return Mapper<Mojio>().map(JSON: dict)
            
        case .trips:
            return Mapper<Trip>().map(JSON: dict)

        case .vehicles:
            return Mapper<Vehicle>().map(JSON: dict)
            
        case .address:
            return Mapper<Address>().map(JSON: dict)
            
        case .vin:
            return Mapper<Vin>().map(JSON: dict)
            
        case .serviceSchedule:
            return Mapper<ServiceSchedule>().map(JSON: dict)
            
        case .next:
            return Mapper<NextServiceSchedule>().map(JSON: dict)

        case .activities:
            return Mapper<RootActivity>().map(JSON: dict)
            
        case .notificationSettings:
            return Mapper<NotificationsSettings>().map(JSON: dict)
            
        case .wifiRadio:
            // Returns Transaction Id
            return dict["TransactionId"]
            
        case .transactions:
            // Returns Transaction State
            return dict["State"]
            
        case .geofences:
            return Mapper<Geofence>().map(JSON: dict)

        case .aggregates:
            return Mapper<AggregationData>().map(JSON: dict)

        case .statistics:
            return Mapper<VehicleStatistics>().map(JSON: dict)
            
        case .polyline:
            return Mapper<TripPolyline>().map(JSON: dict)

        case .diagnosticCodes:
            return Mapper<DiagnosticCode>().map(JSON: dict)
            
        default:
            return nil
        }
    }
    
    func accessToken() -> String? {
        return self.keychainManager.getAuthToken().accessToken
    }    
}

public extension Dictionary {
    public mutating func update(_ updateDict: Dictionary) {
        for (key, value) in updateDict {
            self.updateValue(value, forKey:key)
        }
    }
}

internal extension String {
    func asJSONEncodedString() -> String {
        return "\"" + self
            .replacingOccurrences(of: "\"", with: "\\\"", options: .caseInsensitive)
            .replacingOccurrences(of: "/", with: "\\/", options: .caseInsensitive)
            .replacingOccurrences(of: "\n", with: "\\n", options: .caseInsensitive)
            .replacingOccurrences(of: "\u{8}", with: "\\b", options: .caseInsensitive)
            .replacingOccurrences(of: "\u{12}", with: "\\f", options: .caseInsensitive)
            .replacingOccurrences(of: "\r", with: "\\r", options: .caseInsensitive)
            .replacingOccurrences(of: "\t", with: "\\t", options: .caseInsensitive) + "\""
    }
}
