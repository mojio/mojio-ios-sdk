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

import Foundation
import SwiftWebSocket
import SwiftyJSON
import Alamofire

open class WSPetsClient: PetsClient {
    
    // Default to global concurrent queue with default priority
    public static var wsDefaultDispatchQueue = DispatchQueue.global()
    private var wsDispatchQueue = WSPetsClient.wsDefaultDispatchQueue
    
    private var publicKeys: [SecKey]? = nil
    private let webSocketFactory: WebSocketFactory
    
    public init(
        clientEnvironment: ClientEnvironment,
        sessionManager: SessionManager = SessionManager.default,
        keychainManager: KeychainManager? = nil,
        publicKeys: [SecKey]? = nil,
        webSocketFactory: WebSocketFactory = SwiftWebSocketFactory()) {

        self.publicKeys = publicKeys
        self.webSocketFactory = webSocketFactory
        
        super.init(clientEnvironment: clientEnvironment, sessionManager: sessionManager, keychainManager: keychainManager)
    }
    
    public override func dispatch(queue: DispatchQueue) {
        self.wsDispatchQueue = queue
    }
    
    open func watch(next: @escaping ((Any) -> Void), completion: @escaping (() -> Void), failure: @escaping ((Error) -> Void), file: String = #file) -> WebSocketProvider {
        
        var request = URLRequest(url: URL(string:super.pushUrl!)!)
        request.allHTTPHeaderFields = ClientHeaders().defaultRequestHeaders
        
        if let accessToken: String = super.accessToken() {
            request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        }
        
        webSocketFactory.callbackQueue = self.wsDispatchQueue
        webSocketFactory.pinnedPublicKeys = self.publicKeys
        
        var webSocket = webSocketFactory.create(request: request)
        
        webSocket.onDisconnect = { error in
            if let error = error {
                failure(MojioError(code: "WebSocketError", message: "Error received \(error)"))
            } else {
                completion()
            }
        }
        
        webSocket.onMessage = { message in
            if let text = message as? String {
                if let data = text.data(using: String.Encoding.utf8) {
                    if let dict = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String: Any] {
                        if let obj = super.parseDict(dict) {
                            next(obj as Any)
                        }
                    }
                }
            }
        }
        
        webSocket.connect()
        
        return webSocket
    }
}
