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

open class WSClient: RestClient {
    
    // Default to global concurrent queue with default priority
    public static var wsDefaultDispatchQueue = DispatchQueue.global()
    private var wsDispatchQueue = WSClient.wsDefaultDispatchQueue
    
    private var publicKeys: [SecKey]? = nil
    
    private override init(clientEnvironment: ClientEnvironment, sessionManager: SessionManager = SessionManager.default) {
        super.init(clientEnvironment: clientEnvironment, sessionManager: sessionManager)
    }
    
    public init(clientEnvironment: ClientEnvironment, sessionManager: SessionManager = SessionManager.default, publicKeys: [SecKey]? = nil) {
        super.init(clientEnvironment: clientEnvironment, sessionManager: sessionManager)
        self.publicKeys = publicKeys
    }
    
    public override func dispatch(queue: DispatchQueue) {
        self.wsDispatchQueue = queue
    }
    
    open func watch(next: @escaping ((Any) -> Void), completion: @escaping (() -> Void), failure: @escaping ((Error) -> Void), file: String = #file) -> WebSocket {
    
        var request = URLRequest(url: URL(string:super.pushUrl!)!)
        
        if let accessToken: String = super.accessToken() {
            request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        }
        
        let ws = WebSocket(request: request)
        
        if let publicKeys = self.publicKeys, publicKeys.count > 0 {
            ws.pinnedPublicKeys = publicKeys
        }
        
        ws.eventQueue = self.wsDispatchQueue
        
        ws.event.close = { code, reason, clean in
            print("WEBSOCKET: CLOSED - \(file)")
            completion()
        }
        
        ws.event.error = { error in
            print("WEBSOCKET ERROR:  - \(file): \(error)")
            failure(MojioError(code: "WebSocketError", message: "Error received \(error)"))
        }
        ws.event.open = {
            print("WEBSOCKET: OPENED - \(file)")
        }
        
        ws.event.message = { message in
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
        ws.open()
        
        /*
         return AnonymousDisposable {
         request.cancel()
         }
         */
        
        return ws
    }
}
