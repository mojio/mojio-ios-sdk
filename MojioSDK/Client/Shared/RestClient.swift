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

public enum RestEndpoint: String {
    case base = "/"
}

open class RestClient {
    
    open static let RestClientResponseStatusCodeKey = "statusCode"
    
    internal var requestMethod: Alamofire.HTTPMethod = .get

    open var pushUrl: String?
    open var requestUrl: String?
    open var requestV1Url: String?
    open var requestParams: [String:AnyObject] = [:]
    open var requestEntity: String = RestEndpoint.base.rawValue
    open var requestEntityId: String?
    
    internal var doNext: Bool = false
    internal var nextUrl: String? = nil
    internal var sinceBeforeFormatter = DateFormatter()
    internal static let SinceBeforeDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    internal static let SinceBeforeTimezone = TimeZone(abbreviation: "UTC")

    // Default to global concurrent queue with default priority
    open static var defaultDispatchQueue = DispatchQueue.global()
    
    internal var dispatchQueue = RestClient.defaultDispatchQueue
    
    internal let sessionManager: SessionManager
    internal var keychainManager: KeychainManager

    public init(
        clientEnvironment: ClientEnvironment,
        sessionManager: SessionManager = SessionManager.default,
        keychainManager: KeychainManager? = nil) {

        self.requestUrl = clientEnvironment.getApiEndpoint()
        self.requestV1Url = clientEnvironment.getV1ApiEndpoint()
        self.pushUrl = clientEnvironment.getPushWSEndpoint()
        self.sessionManager = sessionManager
        self.keychainManager = keychainManager ?? KeychainManager.sharedInstance
        
        self.initDateFormatters()
    }
    
    private func initDateFormatters() {
        self.sinceBeforeFormatter.dateFormat = RestClient.SinceBeforeDateFormat
        self.sinceBeforeFormatter.timeZone = RestClient.SinceBeforeTimezone
        self.sinceBeforeFormatter.locale = Locale(identifier: "en_US_POSIX")
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
    
    internal func appendRequestUrlEntityId(asFinal: Bool = false) {
        if let entityId = self.requestEntityId {
            self.requestUrl = self.requestUrl! + self.requestEntity + entityId + (asFinal ? "" : "/")
        }
        else {
            self.requestUrl = self.requestUrl! + self.requestEntity
        }
    }
    
    internal func appendRequestUrlEntity(_ entity: String?, asFinal: Bool = false) {
        if let entity = entity {
            self.requestUrl = self.requestUrl! + entity + (asFinal ? "" : "/")
        }
        else {
            self.requestUrl = self.requestUrl!
        }
    }
    
    internal func appendPushUrlEntityId(asFinal: Bool = false) {
        if let entityId = self.requestEntityId {
            self.pushUrl = self.pushUrl! + self.requestEntity + entityId + (asFinal ? "" : "/")
        }
        else {
            self.pushUrl = self.pushUrl! + self.requestEntity
        }
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
        self.run(completion: {response, headers in completion(response)}, failure: failure)
    }
    open func run(completion: @escaping (_ response: Any, _ headers: [String : Any?]) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        
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
        self.runStringBody(string: string, completion: {response, headers in completion(response)}, failure: failure)
    }
    open func runStringBody(string: String, completion: @escaping (_ response: Any, _ headers: [String : Any?]) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        
        let request = self.sessionManager.request(self.requestUrl!, method: self.requestMethod, parameters: [:], encoding: CustomStringEncoding(customString: string), headers: self.defaultHeaders).responseJSON(queue: self.dispatchQueue, options: .allowFragments) {response in
            self.handleResponse(response, completion: completion, failure: failure)
        }
        
        #if DEBUG
            print(request.debugDescription)
        #endif
    }
    
    open func runEncodeJSON(jsonObject: [String: Any], completion: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        self.runEncodeJSON(jsonObject: jsonObject, completion: {response, headers in completion(response)}, failure: failure)
    }
    open func runEncodeJSON(jsonObject: [String: Any], completion: @escaping (_ response: Any, _ headers: [String : Any?]) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        
        let request = self.sessionManager.request(self.requestUrl!, method: self.requestMethod, parameters: jsonObject, encoding: JSONEncoding.default, headers: self.defaultHeaders).responseJSON(queue: self.dispatchQueue, options: .allowFragments) {response in
            self.handleResponse(response, completion: completion, failure: failure)
        }

        #if DEBUG
            print(request.debugDescription)
        #endif
    }
    
    open func runEncodeUrl(_ parameters: [String: Any], completion: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        self.runEncodeUrl(parameters, completion: {response, headers in completion(response) }, failure: failure)
    }
    open func runEncodeUrl(_ parameters: [String: Any], completion: @escaping (_ response: Any, _ headers: [String : Any?]) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        
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
    
    func handleResponse(_ response: DataResponse<Any>, completion: @escaping (_ response: Any, _ headers: [String : Any?]) -> Void, failure: @escaping (_ error: Any?) -> Void){
        if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
            let headers: [String : Any?] = [
                "ResponseDate" : (response.response?.allHeaderFields["Date"] as? String)?.toDate,
                "LocalDate" : Date()
            ]

            if let responseData = response.data {
                if let responseObject: Any = self.parseData(responseData) {
                    completion(responseObject, headers)
                }
                else {
                    failure(nil)
                }
                
                /* if let dataArray = responseDict["Data"] as? [Any] {
                    
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
                        
                        completion(Result(totalCount: count, data: array), headers)
                    } else {
                        completion(array, headers)
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
                        completion(NextDone(), headers)
                    }
                }
                else {
                    if let obj = self.parseDict(responseDict) {
                        completion (obj, headers)
                    }
                    else {
                        if let message: String = responseDict["Message"] as? String {
                            completion (message, headers)
                        }
                        else {
                            completion ("", headers)
                        }
                    }
                    
                } */
            }
            else if let responseString = response.result.value as? String {
                completion(responseString, headers);
            }
            else {
                completion(true, headers)
            }
        }
        else {
            var errorInfo : [String : Any] = [RestClient.RestClientResponseStatusCodeKey : response.response?.statusCode ?? 0]
            if let responseDict = response.result.value as? Dictionary<String,Any> {
                errorInfo.update(responseDict)
            }
            else if let responseError = response.result.error as NSError? {
                errorInfo.update(responseError.userInfo)
            }
            failure (errorInfo)
        }
    }
    
    internal func parseData(_ responseData: Data) -> Codable? {
        return nil
    }
    
    func accessToken() -> String? {
        return KeychainManager.sharedInstance.authToken?.accessToken
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
