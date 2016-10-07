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


public class WSClient : RestClient {
    
    public func watch(next: ((AnyObject) -> Void), completion: (() -> Void), failure: ((ErrorType) -> Void), file: String = #file) -> WebSocket {
        
        
        let request = NSMutableURLRequest(URL: NSURL(string:super.pushUrl!)!)
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
                if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
                    if let dict = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? NSDictionary {
                        if let obj = super.parseDict(dict) {
                            next(obj)
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
