//
//  WSClient.swift
//  Pods
//
//  Created by Narayan Sainaney on 2016-06-03.
//
//

import Foundation
import SwiftWebSocket
import SwiftyJSON


open class WSClient : RestClient {
    
    open func watch(_ next: @escaping ((Any) -> Void), completion: @escaping (() -> Void), failure: @escaping ((Error) -> Void), file: String = #file) -> WebSocket {

        var request = URLRequest(url: URL(string:super.pushUrl!)!)
        if let accessToken : String = super.accessToken() {
            request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")

        }
        
        let ws = WebSocket(request: request)
        
        ws.event.close = { code, reason, clean in
            print("WEBSOCKET: CLOSED - \(file)")
            completion()
        }
        
        ws.event.error = { error in
            print("WEBSOCKET ERROR:  - \(file) : \(error)")
            failure(MojioError(code: "WebSocketError", message: "Error received \(error)"))
        }
        ws.event.open = {
            print("WEBSOCKET: OPENED - \(file)")
        }
        
        ws.event.message = { message in
            if let text = message as? String {
                if let data = text.data(using: String.Encoding.utf8) {
                    if let dict = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String : Any] {
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
