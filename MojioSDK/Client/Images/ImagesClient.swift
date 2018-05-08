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
import AlamofireImage
import SwiftyJSON
import KeychainSwift
import MojioCore

public enum ImagesEndpoint: String {
    case base = "/"
    case images = "images/"
    case metadata = "metadata/"
}

public protocol MimeVersion {
    var version: String {get}
    var build: String {get}
}

open class ImagesClient: RestClient {
    
    internal init() {
        super.init(clientEnvironment: ClientEnvironment())
    }
    
    public override init(
        clientEnvironment: ClientEnvironment,
        sessionManager: SessionManager = SessionManager.default,
        keychainManager: KeychainManager? = nil) {
        
        super.init(clientEnvironment: clientEnvironment, sessionManager: sessionManager, keychainManager: keychainManager)
    }
    
    open func images(_ imageId: String? = nil) -> Self {
        self.requestEntity = ImagesEndpoint.images.rawValue
        self.requestEntityId = imageId
        self.appendRequestUrlEntityId()
        
        return self
    }
    
    open func metadata() -> Self {
        self.requestEntity = ImagesEndpoint.metadata.rawValue
        self.requestUrl = self.requestUrl! + self.requestEntity
        
        return self
    }
    
    open func uploadImage(_ imageData: Data, mimeType: MimeType.Image, completion: @escaping (Image?) -> Void, failure: @escaping (Any?) -> Void) {
        return self.uploadImage(imageData, mimeType: mimeType, completion: {response, headers in completion(response as? Image)}, failure: failure)
    }
    
    internal func uploadImage(_ imageData: Data, mimeType: MimeType.Image, completion: @escaping (_ response: Codable?, _ headers: [String : String]) -> Void, failure: @escaping (_ error: Any?) -> Void) {
        
        guard let requestUrl = self.requestUrl else {
            failure(nil)
            return
        }
        
        let version = "\(self.version).\(self.build)"
        let name = "ImagesClient.ImageData"
        let fileName = "\(name).\(version)"
        
        self.sessionManager.upload(
            multipartFormData: {multipartFormData in
                multipartFormData.append(imageData, withName: name, fileName: fileName, mimeType: mimeType.rawValue)
        },
            to: requestUrl,
            headers: self.defaultHeaders) {result in
                
                switch result {
                case .success(let request, _, _):
                    request.responseData(queue: self.dispatchQueue) {response in
                        self.handleResponse(response, completion: completion, failure: failure)
                    }
                case .failure(let encodingError):
                    failure(encodingError)
                }
        }
    }
    
    open func runImage(completion: @escaping (UIImage?) -> Void, failure: @escaping (Any?) -> Void) {
        
        guard let requestUrl = self.requestUrl else {
            failure(nil)
            return
        }
        
        let request = self.sessionManager.request(
            requestUrl,
            method: self.requestMethod,
            parameters: self.requestParams,
            encoding: URLEncoding(destination: .methodDependent),
            headers: self.defaultHeaders)
            .responseImage {response in
                completion(response.result.value)
        }
        
        #if DEBUG
        print(request.debugDescription)
        #endif
    }
    
    open override func parseData(_ responseData: Data) -> Codable? {
        do {
            switch ImagesEndpoint(rawValue: self.requestEntity) ?? .base {
            case .images:
                fallthrough
            case .metadata:
                return try JSONDecoder().decode(Image.self, from: responseData)
            default:
                return nil
            }
        }
        catch {
            return nil
        }
    }
}

extension ImagesClient: MimeVersion {
    public var version: String {
        return String.empty
    }
    
    public var build: String {
        return String.empty
    }
}
