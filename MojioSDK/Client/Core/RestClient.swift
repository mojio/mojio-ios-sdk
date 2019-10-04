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
import SwiftDate

open class NextDone {}

open class ClientHeaders {
    private let languages: [String]
    private let languageWeights = [1.0, 0.9, 0.8, 0.7, 0.6, 0.5]
    
    public init(languages: [String] = NSLocale.preferredLanguages) {
        self.languages = languages
    }

    open var defaultRequestHeaders: [String:String] {
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

public struct MimeType {
    public enum Image: String, Codable {
        case jpeg = "image/jpeg"
        case png = "image/png"
        case gif = "image/gif"
        case bmp = "image/bmp"
    }
    
    public enum Application: String, Codable {
        case json = "application/json"
    }
}

public enum SortDirection: String {
    case ascending = "asc"
    case descending = "desc"
}

public enum RestEndpoint: String {
    case base = "/"
}

open class RestClient {
    
    public static let RestClientResponseStatusCodeKey = "statusCode"
    
    open var requestMethod: Alamofire.HTTPMethod = .get
    
    open var pushUrl: String?
    open var requestUrl: String?
    open var requestParams: Parameters = [:]
    open var requestEntity: String = RestEndpoint.base.rawValue
    open var requestEntityId: String?
    fileprivate var versionHeader: String? = nil
    
    internal var doNext: Bool = false
    internal var nextUrl: String? = nil
    
    fileprivate static let sinceBeforeDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    fileprivate static let fromToDateFormat = "yyyy-MM-dd"
    fileprivate static let sinceBeforeTimezone = TimeZone(abbreviation: "UTC");
    
    fileprivate var sinceBeforeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = RestClient.sinceBeforeDateFormat
        formatter.timeZone = RestClient.sinceBeforeTimezone
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    fileprivate var fromToDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = RestClient.fromToDateFormat
        formatter.timeZone = RestClient.sinceBeforeTimezone
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    // Default to global concurrent queue with default priority
    public static var defaultDispatchQueue = DispatchQueue.global()
    
    open var dispatchQueue = RestClient.defaultDispatchQueue
    
    public let sessionManager: SessionManager
    internal var keychainManager: KeychainManager
    
    public init(
        clientEnvironment: ClientEnvironment,
        sessionManager: SessionManager = SessionManager.default,
        keychainManager: KeychainManager? = nil) {
        
        self.requestUrl = clientEnvironment.getApiEndpoint()
        self.pushUrl = clientEnvironment.getPushWSEndpoint()
        self.sessionManager = sessionManager
        self.keychainManager = keychainManager ?? KeychainManager.sharedInstance
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
    
    open func patch() -> Self {
        self.requestMethod = .patch
        return self
    }
    
    open func delete() -> Self {
        self.requestMethod = .delete
        return self
    }
    
    open func v1() -> Self {
        self.requestUrl = self.requestUrl! + "v1/"
        return self
    }
    
    open func v2() -> Self {
        self.requestUrl = self.requestUrl! + "v2/"
        return self
    }
    
    open func v3() -> Self {
        self.versionHeader = "2018-09-01"
        return self
    }
    
    open func offset(offset: Int) -> Self {
        self.requestParams["skip"] = offset
        return self
    }
    
    open func limit(limit: Int) -> Self {
        self.requestParams["top"] = limit
        return self
    }
    
    open func sortBy(field: String, direction: SortDirection) -> Self {
        self.requestParams["orderby"] = "\(field) \(direction.rawValue)"
        return self
    }
    
    open func includeCount() -> Self {
        self.requestParams["includeCount"] = true
        return self
    }
    
    open func from(fromDate: Date, includeTime: Bool = false) -> Self {
        let fromStr = includeTime ? self.sinceBeforeFormatter.string(from: fromDate) : self.fromToDateFormatter.string(from: fromDate)
        self.requestParams["from"] = fromStr
        return self
    }
    
    open func to(toDate: Date, includeTime: Bool = false) -> Self {
        let toStr = includeTime ? self.sinceBeforeFormatter.string(from: toDate) : self.fromToDateFormatter.string(from: toDate)
        self.requestParams["to"] = toStr
        return self
    }
    
    open func since(sinceDate: Date) -> Self {
        self.requestParams["since"] = self.sinceBeforeFormatter.string(from: sinceDate)
        return self
    }
    
    open func before(beforeDate: Date) -> Self {
        self.requestParams["before"] = self.sinceBeforeFormatter.string(from: beforeDate)
        return self
    }
    
    open func top(top: String) -> Self {
        self.requestParams["top"] = top
        return self
    }
    
    open func skip(skip: String) -> Self {
        self.requestParams["skip"] = skip
        return self
    }
    
    open func filter(filter: String) -> Self {
        self.requestParams["filter"] = filter
        return self
    }
    
    open func select(select: String) -> Self {
        self.requestParams["select"] = select
        return self
    }
    
    open func orderby(orderby: String) -> Self {
        self.requestParams["orderby"] = orderby
        return self
    }
    
    open func count(count: String) -> Self {
        self.requestParams["count"] = count
        return self
    }
    
    open func fields(fields: [String]) -> Self {
        if fields.count > 0 {
            self.requestParams["fields"] = fields.joined(separator: ",")
        }
        
        return self
    }
    
    open func continueNext() -> Self {
        self.doNext = true
        return self
    }
    
    open func appendRequestUrlEntityId(asFinal: Bool = false) {
        if let entityId = self.requestEntityId {
            self.requestUrl = self.requestUrl! + self.requestEntity + entityId + (asFinal ? "" : "/")
        }
        else {
            self.requestUrl = self.requestUrl! + self.requestEntity
        }
    }
    
    open func appendRequestUrlEntity(_ entity: String?, asFinal: Bool = false) {
        if let entity = entity {
            self.requestUrl = self.requestUrl! + entity + (asFinal ? "" : "/")
        }
        else {
            self.requestUrl = self.requestUrl!
        }
    }
    
    open func appendPushUrlEntityId(asFinal: Bool = false) {
        if let entityId = self.requestEntityId {
            self.pushUrl = self.pushUrl! + self.requestEntity + entityId + (asFinal ? "" : "/")
        }
        else {
            self.pushUrl = self.pushUrl! + self.requestEntity
        }
    }
    
    open func query(top: String? = nil, skip: String? = nil, filter: String? = nil, select: String? = nil, orderby: String? = nil, count: String? = nil, since: Date? = nil, before: Date? = nil, fields: [String]? = nil) -> Self {
        
        var requestParams: Parameters = [:]
        
        if let top = top {
            requestParams["top"] = top
        }
        
        if let skip = skip {
            requestParams["skip"] = skip
        }
        
        if let filter = filter {
            requestParams["filter"] = filter
        }
        
        if let select = select {
            requestParams["select"] = select
        }
        
        if let orderby = orderby {
            requestParams["orderby"] = orderby
        }
        
        if let count = count {
            requestParams["includeCount"] = count
        }
        
        if let date = since {
            requestParams["since"] = self.sinceBeforeFormatter.string(from: date)
        }
        
        if let date = before {
            requestParams["before"] = self.sinceBeforeFormatter.string(from: date)
        }
        
        if let fields = fields , fields.count > 0 {
            requestParams["fields"] = fields.joined(separator: ",")
        }
        
        self.requestParams.update(requestParams)
        return self
    }
    
    open func dispatch(queue: DispatchQueue) {
        self.dispatchQueue = queue
    }
    
    /*
     Don't need this helper function given default values in the other query function
     public func query(top: String?, skip: String?, filter: String?, select: String?, orderby: String?) -> Self {
     return self.query(top, skip: skip, filter: filter, select: select, orderby: orderby, since: nil, before: nil, fields: nil)
     }*/
    open func run(completion: @escaping (_ response: Codable?) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        self.run(completion: {response, headers in completion(response)}, failure: failure)
    }
    
    internal func run(completion: @escaping (_ response: Codable?, _ headers: [String:String]) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        
        let request = self.sessionManager.request(
            self.requestUrl!,
            method: self.requestMethod,
            parameters: self.requestParams.mapValues {
                if let boolValue = $0 as? Bool {
                    return boolValue ? "true" : "false"
                }
                
                return $0
            },
            encoding: URLEncoding(destination: .methodDependent),
            headers: self.defaultHeaders)
            .responseData(queue: self.dispatchQueue) {response in
                self.handleResponse(response, completion: completion, failure: failure)
        }
        
        print(request)
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
    
    open var defaultHeaders: [String:String] {
        var headers = ClientHeaders().defaultRequestHeaders
        
        headers.update(["Content-Type": "application/json", "Accept": "application/json"])
        
        // Before every request, make sure access token exists
        if let accessToken: String = self.accessToken() {
            headers["Authorization"] = "Bearer " + accessToken
        }
        
        // Add version header if needed
        if self.versionHeader != nil {
            headers["x-mojio-version"] = "2018-09-01"
        }
        
        return headers
    }
    
    open func runStringBody(string: String, completion: @escaping (_ response: Codable?) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        self.runStringBody(string: string, completion: {response, headers in completion(response)}, failure: failure)
    }
    
    internal func runStringBody(string: String, completion: @escaping (_ response: Codable?, _ headers: [String:String]) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        
        let request = self.sessionManager.request(
            self.requestUrl!,
            method: self.requestMethod,
            parameters: [:],
            encoding: CustomStringEncoding(customString: string),
            headers: self.defaultHeaders)
            .responseData(queue: self.dispatchQueue) {response in
                self.handleResponse(response, completion: completion, failure: failure)
        }
        
        print(request)
    }
    
    open func runEncodeJSON(jsonObject: [String: Codable], completion: @escaping (_ response: Codable?) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        self.runEncodeJSON(jsonObject: jsonObject, completion: {response, headers in completion(response)}, failure: failure)
    }
    
    internal func runEncodeJSON(jsonObject: [String: Codable], completion: @escaping (_ response: Codable?, _ headers: [String:String]) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        
        let request = self.sessionManager.request(
            self.requestUrl!,
            method: self.requestMethod,
            parameters: jsonObject,
            encoding: JSONEncoding.default,
            headers: self.defaultHeaders)
            .responseData(queue: self.dispatchQueue) {response in
                self.handleResponse(response, completion: completion, failure: failure)
        }
        
        print(request)
    }
    
    fileprivate class CodableJSONEncoding<T: Encodable>: ParameterEncoding {
        
        private let codableObject: T
        
        init(codableObject: T) {
            self.codableObject = codableObject
        }
        
        func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
            var urlRequest = urlRequest.urlRequest
            
            do {
                let encoder = JSONEncoder()
                if #available(iOS 10.0, *) {
                    encoder.dateEncodingStrategy = .iso8601
                }
                else {
                    encoder.dateEncodingStrategy = .millisecondsSince1970
                }
                let data = try encoder.encode(self.codableObject)
                urlRequest?.httpBody = data
                urlRequest?.setValue(MimeType.Application.json.rawValue, forHTTPHeaderField: "Content-Type")
            }
            catch {}
            
            return urlRequest!
        }
    }
    
    open func runEncodeJSON<T: Codable>(codableObject: T, completion: @escaping (_ response: Codable?) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        self.runEncodeJSON(codableObject: codableObject, completion: {response, headers in completion(response)}, failure: failure)
    }
    
    internal func runEncodeJSON<T: Codable>(codableObject: T, completion: @escaping (_ response: Codable?, _ headers: [String:String]) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        
        let request = self.sessionManager.request(
            self.requestUrl!,
            method: self.requestMethod,
            parameters: self.requestParams,
            encoding: CodableJSONEncoding<T>(codableObject: codableObject),
            headers: self.defaultHeaders)
            .responseData(queue: self.dispatchQueue) {response in
                self.handleResponse(response, completion: completion, failure: failure)
        }
        
        print(request)
    }
    
    open func runEncodeUrl(_ parameters: [String: Any], completion: @escaping (_ response: Codable?) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        self.runEncodeUrl(parameters, completion: {response, headers in completion(response) }, failure: failure)
    }
    
    internal func runEncodeUrl(_ parameters: [String: Any], completion: @escaping (_ response: Codable?, _ headers: [String:String]) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        
        // Before every request, make sure access token exists
        var headers: [String:String] = [:]
        
        if let accessToken: String = self.accessToken() {
            headers["Authorization"] = "Bearer " + accessToken
        }
        
        let request = self.sessionManager.request(
            self.requestUrl!,
            method: self.requestMethod,
            parameters: parameters,
            encoding: URLEncoding(destination: .methodDependent),
            headers: headers)
            .responseData(queue: self.dispatchQueue) {response in
                self.handleResponse(response, completion: completion, failure: failure)
        }
        
        print(request)
    }
    
    open func handleResponse(_ response: DataResponse<Data>, completion: @escaping (_ response: Codable?, _ headers: [String:String]) -> Void, failure: @escaping (_ error: Any?) -> Void){
        
        // Purpose?
        var headers: [String:String] = [:]
        
        headers["LocalDate"] = Date().toISO(.withInternetDateTime)
        
        if let respDateStr = (response.response?.allHeaderFields["Date"] as? String), let _ = respDateStr.toDate {
            headers["ResponseDate"] = respDateStr
        }
        
        if
            response.response?.statusCode == 200 || response.response?.statusCode == 201,
            let responseData = response.data
        {
            if let parsedData = self.parseData(responseData) {
                completion(parsedData, headers)
            }
            else if let httpMethod = response.request?.httpMethod, httpMethod == HTTPMethod.delete.rawValue {
                completion(true, headers)
            }
            else {
                failure(self.parseError(response))
            }
        }
        else {
            failure(self.parseError(response))
        }
    }
    
    open func runCustomStringBody(string: String, completion: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        self.runCustomStringBody(string: string, completion: {response, headers in completion(response)}, failure: failure)
    }
    
    open func runCustomStringBody(string: String, completion: @escaping (_ response: Any, _ headers: [String : Any?]) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        
        let request = self.sessionManager.request(self.requestUrl!, method: self.requestMethod, parameters: [:], encoding: CustomStringEncoding(customString: string), headers: self.defaultHeaders).responseJSON(queue: self.dispatchQueue, options: .allowFragments) {response in
            self.handleCustomJSONResponse(response, completion: completion, failure: failure)
        }
        
        print(request)
    }
    
    open func runCustomJSON(completion: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        self.runCustomJSON(completion: {response, headers in completion(response)}, failure: failure)
    }
    
    open func runCustomJSON(completion: @escaping (_ response: Any, _ headers: [String : Any?]) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        
        let request = self.sessionManager.request(
            self.requestUrl!,
            method: self.requestMethod,
            parameters: self.requestParams.mapValues {
                if let boolValue = $0 as? Bool {
                    return boolValue ? "true" : "false"
                }
                
                return $0
            },
            encoding: URLEncoding(destination: .methodDependent),
            headers: self.defaultHeaders).responseJSON(queue: self.dispatchQueue, options: .allowFragments) {response in
                self.handleCustomJSONResponse(response, completion: completion, failure: failure)
        }
        
        print(request)
    }
    
    func handleCustomJSONResponse(_ response: DataResponse<Any>, completion: @escaping (_ response: Any, _ headers: [String : Any?]) -> Void, failure: @escaping (_ error: Any?) -> Void){
        if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
            let headers: [String : Any?] = [
                "ResponseDate" : (response.response?.allHeaderFields["Date"] as? String)?.toDate,
                "LocalDate" : Date()
            ]
            
            if let responseString = response.result.value as? String {
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
    
    open func parseData(_ responseData: Data) -> Codable? {
        return nil
    }
    
    open func parseError(_ response: DataResponse<Data>) -> Error {
        return MojioError(code: nil)
    }
    
    open func accessToken() -> String? {
        return KeychainManager.sharedInstance.authToken?.accessToken
    }
}

public extension Dictionary {
    mutating func update(_ updateDict: Dictionary) {
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
